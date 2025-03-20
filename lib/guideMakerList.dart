import 'package:appen/guide.dart';
import 'package:appen/guidegetter.dart';
import 'package:appen/guidemake.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuideMakerList extends StatefulWidget {
  @override
  _guideTitlesView createState() => _guideTitlesView();
}

Future<int> countDocs() async {
  final QuerySnapshot qSnap =
      await FirebaseFirestore.instance.collection('guides').get();
  final int documents = qSnap.docs.length;
  //print("count" + documents.toString());

  return documents;
}

class _guideTitlesView extends State<GuideMakerList> {
  List<String> guideTitles = ["Hej"];
  GuideGetter guideGetter = GuideGetter(1);
  final textEditingController = TextEditingController();

  int documents = 0;

  void fetchData() async {
    await countDocs().then((value) => documents = value);
    print("fetch" + documents.toString());

    for (var i = 0; i < documents; i++) {
      guideTitles.add(i.toString());
    }
    setState(() {});
  }

  void fetchTitles() async {
    guideTitles = await guideGetter
        .getGuideTitles()
        .then((value) => guideTitles = value.cast<String>());
    setState(() {});
  }

  void createGuide(int guideID, String guideTitle) async {
    Guide guide = Guide(guideID, {}, {}, guideTitle);
    await guide.uploadToFirestore().then((value) {
      fetchTitles();
    });
  }

  @override
  void initState() {
    fetchTitles();
    //fetchData();
    print("contruct$documents");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Listview'),
        ),
        body: Center(
            child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: guideTitles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          if (index == 0) {
                            return;
                          }
                          final item = guideTitles[index];
                          setState(() {
                            guideGetter.swapGuideID(index, index - 1);

                            guideTitles.removeAt(index);
                            guideTitles.insert(index - 1, item);
                          });
                        },
                      ),
                      Text(guideTitles[index]),
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          if (index == guideTitles.length - 1) {
                            return;
                          }
                          final item = guideTitles[index];
                          setState(() {
                            guideGetter.swapGuideID(index, index + 1);
                            guideTitles.removeAt(index);
                            guideTitles.insert(index + 1, item);
                          });
                        },
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuideMaker(guideIndex: index),
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter guide title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  createGuide(guideTitles.length, textEditingController.text);
                },
                child: Text('Create guide'),
              ),
            ),
          ],
        )));
  }
}
