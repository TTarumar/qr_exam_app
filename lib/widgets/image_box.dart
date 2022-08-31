import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  final double width;
  final double height;

  const ImageBox({Key key, this.width, this.height}) : super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Image(
      width: widget.width,
      height: widget.height,
      image: AssetImage("lib/assets/qr-code.png"),
    );
  }
}
