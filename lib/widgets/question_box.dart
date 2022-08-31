import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class QuestionBox extends StatefulWidget {
  final String question;
  const QuestionBox({Key key, this.question}) : super(key: key);

  @override
  State<QuestionBox> createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: HexColor("#41337A"),
      ),
      child: Center(
        child: Text(
          widget.question,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.047,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
