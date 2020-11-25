import 'package:flutter/material.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            child: Container(
              height: 100,
              child: Card(
                color: Colors.deepPurpleAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title $index'),
                    Row(
                      children: [
                        Text('date'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('section')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMemoScreen()));
        },
      ),
    );
  }
}
