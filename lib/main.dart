import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'package:flutter_tesseract_sample/image_file_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tesseract OCR'),
        ),
        body: SignForm(),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Uint8List imageBytes;
  File imageFile;
  String extractText = '認識された文字がここに表示される';

  void ocrSignature() async {
    imageBytes = await _controller.toPngBytes();
    imageFile = await ImageFileManager.saveImageWithBytes(imageBytes);
    extractText =
        await TesseractOcr.extractText(imageFile.path, language: 'jpn');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Signature(
          controller: _controller,
          height: MediaQuery.of(context).size.height / 2,
          backgroundColor: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _controller.clear();
              },
              child: Text('クリア'),
            ),
            RaisedButton(
              onPressed: () {
                ocrSignature();
              },
              child: Text('文字認識'),
            ),
          ],
        ),
        Text(
          extractText,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
