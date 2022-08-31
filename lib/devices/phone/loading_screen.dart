import 'package:qr_exam_app/devices/phone/exam_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/answer_box.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          children: [
            SizedBox(
              height: size.height * 0.3,
            ),
            Text(
              "Diğer öğrencilerin katılması bekleniyor...",
              style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#41337A")),
              textAlign: TextAlign.center,
            ),
            Button(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExamPage()));
              },
              text: "Başla",
              color: HexColor("#6EA4BF"),
              width: size.width * 0.3,
              height: size.height * 0.06,
              radius: 30,
              fontSize: size.width * 0.037,
            ),
          ],
        ),
      ),
    );
  }
}
