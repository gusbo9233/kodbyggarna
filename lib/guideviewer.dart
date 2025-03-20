import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'guidegetter.dart';

class GuideViewer extends StatefulWidget {
  late int guideIndex;
  GuideViewer({super.key, required this.guideIndex});

  @override
  State<GuideViewer> createState() => _GuideViewerState();
}

String getHtml(dynamic obj) {
  final converter = QuillDeltaToHtmlConverter(List.castFrom(obj));

  final html = converter.convert();
  return html;
}

class _GuideViewerState extends State<GuideViewer> {
  String initialText = "-------------------------------->";

  late String currentText;
  late String currentImageUrl;

  int index = 0;
  bool loading = true;
  //Map<String, dynamic> imageUrls = getImgUrls() as Map<String, dynamic>;

  Map<String, dynamic> textMap = {};
  Map<String, dynamic> imgageUrlMap = {};
  //Map<String, dynamic> textMap;

  //Map<String, dynamic> textMap = guideGetter.getTextMap();

  void loadData(guideIndex) async {
    await fetchData(guideIndex).then((value) {
      loading = false;
      currentImageUrl = imgageUrlMap[index.toString()];
      currentText = getHtml(textMap[index.toString()]);
      setState(() {});
    });
  }

  Future<void> fetchData(int guideID) async {
    GuideGetter guideGetter = GuideGetter(guideID);
    await guideGetter
        .fetchTexts()
        .then((value) => textMap = guideGetter.getTextMap());
    await guideGetter
        .fetchImgUrls()
        .then((value) => imgageUrlMap = guideGetter.getImageUrlMap());
    //textMap = guideGetter.getTextMap();
  }

  @override
  void initState() {
    loadData(widget.guideIndex);
    print("3333333");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("11111111111");
    if (loading) return const CircularProgressIndicator();
    print("22222222");

    //gettextMap();
    return Scaffold(
        appBar: AppBar(
          title: const Text('HTML Screen'),
        ),
        body: Center(
            child: Column(children: [
          Image.network(currentImageUrl, height: 100, width: 200),
          Html(data: currentText)
        ])),
        bottomNavigationBar: BottomAppBar(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    if (index > -1) {
                      index--;
                      currentText = getHtml(textMap[index.toString()]);
                      currentImageUrl = imgageUrlMap[index.toString()];
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    if (index < textMap.length - 1) {
                      index++;
                      currentText = getHtml(textMap[index.toString()]);
                      currentImageUrl = imgageUrlMap[index.toString()];
                    }

                    //queryDoc();
                  });
                },
              )
            ])));
  }
}
