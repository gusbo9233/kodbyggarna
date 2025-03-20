import 'package:flutter/material.dart';

class ImageTextScreen extends StatefulWidget {
  @override
  _ImageTextState createState() => _ImageTextState();
}

class _ImageTextState extends State<ImageTextScreen> {
  String _imagePath = 'assets/placeholder.png';
  String _textContent = 'This is a placeholder text';

  void _updateImage() {
    setState(() {
      _imagePath = 'assets/updated_image.png';
    });
  }

  void _updateTextContent() {
    setState(() {
      _textContent = 'This is an updated text content';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(_imagePath),
            Text(_textContent),
            ElevatedButton(
              onPressed: () {
                _updateImage();
                _updateTextContent();
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
