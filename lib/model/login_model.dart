import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sunday_note/common/shared_preferences.dart';

class LoginModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void changeLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithGoogle() async {
    print('clicked SignInWith Google');
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print(googleSignInAccount);
    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        print(googleSignInAuthentication.accessToken);
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        print('credential : $credential');
        final authResult = await _auth.signInWithCredential(credential);
        final User user = authResult.user;
        SharedPreference.setUserEmail(user.email);
        final User currentUser = await _auth.currentUser;
        print('try{');
        print(currentUser.displayName);
        return authResult;
      } on FirebaseAuthException catch (e) {
        print("***ERROR***");
        print(e);
        rethrow;
      }
    } else {
      return null;
    }
  }

  Future<void> addUser() {
    return users
        .add({
      'displayName': _auth.currentUser.displayName,
      'email': _auth.currentUser.email,
      'date': DateTime.now().toUtc().toString()
    })
        .then((value) => print('User Added : ${value.path}'))
        .catchError((err) => print('Failed to add user : $err'))
        .whenComplete(() => print('Complete addUser'));
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    print('rawNonce : $rawNonce');
    print('nonce : $nonce');
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName
          ],
          nonce: nonce);
      print('appleCredential : $appleCredential');
      final oauthCredential = OAuthProvider("apple.com");

      final credential = oauthCredential.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      print(oauthCredential);

      final authResult = await _auth.signInWithCredential(credential);

      print(authResult.user.email);

      final User user = authResult.user;
      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      print(appleCredential);

      await user.updateProfile(displayName: displayName);
      print('displayName : $displayName');
      print(user.displayName);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = await _auth.currentUser;
      assert(user.uid == currentUser.uid);
      SharedPreference.setUserEmail(currentUser.email);

      assert(authResult.user.displayName != null);
      assert(authResult.user.email != null);
      return authResult;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
