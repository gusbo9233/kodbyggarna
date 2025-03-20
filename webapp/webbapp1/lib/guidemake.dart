import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:webbapp1/guide.dart';

class GuideMaker extends StatefulWidget {
  final int guideIndex;
  GuideMaker({super.key, required this.guideIndex});

  @override
  _GuideMakerState createState() => _GuideMakerState();
}

class _GuideMakerState extends State<GuideMaker> {
  int index = 0;
  Map<int, String> imageUrl = {};
  Map<int, String> text = {};
  final urlController = TextEditingController();
  final textController = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();
  String imagePlaceholderUrl =
      "https://via.placeholder.com/150"; // Placeholder image URL instead of Firebase URL
  String imageURL =
      "https://via.placeholder.com/150"; // Placeholder image URL instead of Firebase URL

  Future<void> downloadFile(String filename) async {
    final ref = FirebaseStorage.instance.ref().child(filename);
    var url = await ref.getDownloadURL();
    setState(() {
      imageURL = url;
      imageUrl[index] = url;
    });
  }

  void uploadData() {
    Guide guide = Guide(widget.guideIndex, imageUrl, text);
    guide.uploadToFirestore();
  }

  void saveCurrentState() {
    setState(() {
      text[index] = textController.text;
    });
  }

  void loadCurrentState() {
    setState(() {
      if (text.containsKey(index)) {
        textController.text = text[index]!;
      } else {
        textController.clear();
      }

      if (imageUrl.containsKey(index)) {
        imageURL = imageUrl[index]!;
      } else {
        imageURL = imagePlaceholderUrl;
        urlController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(imageURL, height: 100, width: 200),
            Text('Index: $index'),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            TextField(
              controller: textController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Enter text here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: text.entries.map((entry) {
                      return TextSpan(
                        text: entry.value,
                        style: TextStyle(fontSize: 16.0),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Text('Image URL: ${imageUrl[index]}'),
            Text('Text: ${text[index]}'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo_rounded),
              onPressed: () {
                downloadFile(urlController.text);
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () {
                saveCurrentState();
                setState(() {
                  index--;
                  loadCurrentState();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                setState(() {
                  text[index] = textController.text;
                  imageUrl[index] = urlController.text;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                saveCurrentState();
                setState(() {
                  index++;
                  loadCurrentState();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                uploadData();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  imageUrl.remove(index);
                  text.remove(index);
                  textController.clear();
                  urlController.clear();
                  imageURL = imagePlaceholderUrl;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
