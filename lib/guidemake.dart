import 'package:appen/guide.dart';
import 'package:appen/guidegetter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class GuideMaker extends StatefulWidget {
  int guideIndex;
  GuideMaker({super.key, required this.guideIndex});

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<GuideMaker> {
  int index = 0;
  Map<int, String> imageUrl = {};
  Map<int, dynamic> text = {};
  Map<String, dynamic> imageUrlMap = {};
  Map<String, dynamic> textMap = {};
  String guideTitle = "Guide";
  final urlController = TextEditingController();
  final textController = TextEditingController();
  QuillController _controller = QuillController.basic();
  final storageRef = FirebaseStorage.instance.ref();
  bool loading = true;
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

  @override
  void initState() {
    guideTitle = guideTitle + widget.guideIndex.toString();
    transformData(widget.guideIndex);
    super.initState();
  }

  List<Map?> transform(List<dynamic> list) {
    return list.map((item) => item is Map ? item : null).toList();
  }

  List<Map<String, dynamic>> transform2(List<Map<dynamic, dynamic>> list) {
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  void transformData(guideID) async {
    await getData(guideID).then((value) {
      imageUrlMap.forEach((key, value) {
        imageUrl[int.parse(key)] = value;
      });
      printTextMap();
      loading = false;
      setState(() {
        if (text.containsKey(index)) {
          _controller = QuillController(
            document: Document.fromJson(text[index]),
            selection: const TextSelection.collapsed(offset: 0),
          );
        }
        if (imageUrl.containsKey(index)) {
          imageURL = imageUrl[index]!;
        }
      });
    });
  }

  void printTextMap() {
    textMap.forEach((key, value) {
      List<Map<String, dynamic>> l2 = [];
      var l = value as List;
      for (var element in l) {
        //print(element.runtimeType);
        l2.add(element as Map<String, dynamic>);
      }
      text[int.parse(key)] = l2;
      print(int.parse(key));
      print(text[int.parse(key)]);
    });
  }

  Future<void> getData(int guideID) async {
    GuideGetter guideGetter = GuideGetter(guideID);
    await guideGetter
        .fetchTexts()
        .then((value) => textMap = guideGetter.getTextMap());
    await guideGetter
        .fetchImgUrls()
        .then((value) => imageUrlMap = guideGetter.getImageUrlMap());
  }

  void uploadData() {
    Guide guide = Guide(widget.guideIndex, imageUrl, text, guideTitle);
    guide.updateDocument();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();

    return Scaffold(
      appBar: AppBar(),
      body: Center(

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(imageURL, height: 100, width: 200),
          Text('Index: $index'),
          TextField(
            controller: urlController,
            onChanged: (value) {
              //imageUrl[index] = value;
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
          QuillToolbar.basic(controller: _controller),
          Expanded(
            child: Container(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
              ),
            ),
          ),
          Text('Image URL: ${imageUrl[index]}'),
          Text('Text: ${text[index]}'),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_a_photo_rounded),
              onPressed: () {
                downloadFile(urlController.text);
                setState(() {});
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                setState(() {
                  index--;
                  print("AHHHHHHHHH");
                  if (text.containsKey(index)) {
                    print(text[index]);

                    _controller = QuillController(
                      document: Document.fromJson(text[index]),
                      selection: const TextSelection.collapsed(offset: 0),
                    );
                  } else {
                    _controller.clear();
                  }
                  if (imageUrl.containsKey(index)) {
                    //urlController.text = imageUrl[index]!;
                    imageURL = imageUrl[index]!;
                  } else {
                    imageURL = imagePlaceholderUrl;

                    urlController.text = "";
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_box),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                setState(() {
                  var jsons = _controller.document.toDelta().toJson();
                  print("jsons ${jsons.runtimeType}");
                  text[index] = jsons;
                  index++;

                  if (text.containsKey(index)) {
                    print(text[index]);

                    _controller = QuillController(
                      document: Document.fromJson(text[index]),
                      selection: const TextSelection.collapsed(offset: 0),
                    );
                  } else {
                    textController.text = "";
                    _controller.clear();
                  }
                  if (imageUrl.containsKey(index)) {
                    imageURL = imageUrl[index]!;
                  } else {
                    imageURL = imagePlaceholderUrl;
                    urlController.text = "";
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                uploadData();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  imageUrl.removeWhere((key, value) => key == index);
                  text.removeWhere((key, value) => key == index);
                  textController.text = "";
                  urlController.text = "";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
