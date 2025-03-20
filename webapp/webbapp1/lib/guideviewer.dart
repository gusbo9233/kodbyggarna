import 'package:flutter/material.dart';
import 'guidegetter.dart';

class GuideViewer extends StatefulWidget {
  final int guideIndex;
  GuideViewer({super.key, required this.guideIndex});

  @override
  State<GuideViewer> createState() => _GuideViewerState();
}

class _GuideViewerState extends State<GuideViewer> {
  int index = 0;
  bool loading = true;
  Map<int, String> imageUrlMap = {};
  Map<int, String> textMap = {};
  String currentText = "";
  String currentImageUrl = "";
  String placeholderImageUrl =
      "https://via.placeholder.com/150"; // Placeholder image URL

  void loadData(int guideIndex) async {
    await fetchData(guideIndex).then((value) {
      loading = false;
      currentImageUrl = imageUrlMap[index] ?? placeholderImageUrl;
      currentText = textMap[index] ?? '';
      setState(() {});
    });
  }

  Future<void> fetchData(int guideID) async {
    GuideGetter guideGetter = GuideGetter(guideID);
    await guideGetter.fetchTexts().then(
        (value) => textMap = guideGetter.getTextMap().cast<int, String>());
    await guideGetter.fetchImgUrls().then((value) =>
        imageUrlMap = guideGetter.getImageUrlMap().cast<int, String>());
  }

  @override
  void initState() {
    super.initState();
    loadData(widget.guideIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide Viewer'),
      ),
      body: Center(
        child: Column(
          children: [
            if (currentImageUrl.isNotEmpty)
              Image.network(currentImageUrl, height: 100, width: 200,
                  errorBuilder: (context, error, stackTrace) {
                return Image.network(placeholderImageUrl,
                    height: 100, width: 200);
              })
            else
              Image.network(placeholderImageUrl, height: 100, width: 200),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: parseRichText(currentText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                setState(() {
                  if (index > 0) {
                    index--;
                    currentText = textMap[index] ?? '';
                    currentImageUrl = imageUrlMap[index] ?? placeholderImageUrl;
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
                    currentText = textMap[index] ?? '';
                    currentImageUrl = imageUrlMap[index] ?? placeholderImageUrl;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> parseRichText(String text) {
    // This function should parse your text and convert it to a list of TextSpans.
    // For simplicity, this example assumes plain text.
    return [TextSpan(text: text)];
  }
}
