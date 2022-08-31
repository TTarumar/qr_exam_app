import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../result_person.dart';

class ResultPage extends StatefulWidget {
  final int point;

  const ResultPage({Key key, this.point,}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: HexColor("#41337A"),
        title: const Text(
          "QR Exam",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sınavınız bitti.", style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold)),
              Text("Puan", style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold)),
              Text(widget.point.toString(), style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold, color: Colors.red))

            ],
          ),
      )
    );
  }
}
