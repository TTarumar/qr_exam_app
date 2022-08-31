import 'package:qr_exam_app/devices/web/choose_exam.dart';
import 'package:qr_exam_app/devices/web/home_page.dart';
import 'package:qr_exam_app/result_person.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class WebResultPage extends StatefulWidget {
  final int point;
  const WebResultPage({Key key, this.point}) : super(key: key);

  @override
  State<WebResultPage> createState() => _WebResultPageState();
}

class _WebResultPageState extends State<WebResultPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor("#3F1A89"),
      appBar: AppBar(
        leadingWidth: size.width * 0.15,
        leading: Center(
            child: Text(
          "QR Exam",
          style: TextStyle(
              fontSize: size.width * 0.034, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        backgroundColor: HexColor("#391778"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChooseExamPage()));
              },
              child: Text(
                "ÇIKIŞ YAP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.02,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sınavınız bitti.", style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold,color: Colors.white)),
            Text("Puan", style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold,color: Colors.white)),
            Text(widget.point.toString(), style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold, color: Colors.red))

          ],
        ),
      )
    );
  }
}
