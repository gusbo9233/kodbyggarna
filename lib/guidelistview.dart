import 'package:appen/guideviewer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListView createState() => _MyListView();
}

Future<int> countDocs() async {
  final QuerySnapshot qSnap =
      await FirebaseFirestore.instance.collection('guides').get();
  final int documents = qSnap.docs.length;
  //print("count" + documents.toString());

  return documents;
}

class _MyListView extends State<MyListView> {
  final List<String> myList = [];

  int documents = 0;

  void fetchData() async {
    await countDocs().then((value) => documents = value);
    print("fetch$documents");

    for (var i = 0; i < documents; i++) {
      myList.add(i.toString());
    }
    setState(() {});
  }

  _MyListView() {
    fetchData();
    print("contruct$documents");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listview'),
      ),
      body: ListView.builder(
        itemCount: documents,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuideViewer(guideIndex: index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
