import 'package:flutter/material.dart';

class AddMemoScreen extends StatefulWidget {
  @override
  _AddMemoScreenState createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(child: Text('Add Memo Screen')),
    );
  }
}
