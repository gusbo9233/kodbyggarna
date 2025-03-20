import 'package:flutter/material.dart';
import 'package:webbapp1/imagetext.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListView createState() => _MyListView();
}

class _MyListView extends State<MyListView> {
  final List<String> myList = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listview'),
      ),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageTextScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
