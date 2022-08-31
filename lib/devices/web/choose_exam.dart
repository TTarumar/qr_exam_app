import 'dart:convert';

import 'package:qr_exam_app/model/question_class.dart';
import 'package:qr_exam_app/devices/web/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';


class ChooseExamPage extends StatefulWidget {
  const ChooseExamPage({Key key}) : super(key: key);

  @override
  State<ChooseExamPage> createState() => _ChooseExamPageState();
}

class _ChooseExamPageState extends State<ChooseExamPage> {
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
      ),
      body: Column(children: [
        Container(
          child: Text(
            "Sınavlar",
            style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
/*
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Bilgisayar Ve Programlamaya Giriş",qrCode: "assets/bilgisayar.png",pin: "102",)));
*/
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Bilgisayar Ve Programlamaya Giriş",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Sistem Analizi Ve Tasarımı",qrCode: "assets/sistem.png",pin: "101",)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Sistem Analizi Ve Tasarımı",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Algoritmalar ve Programlama",qrCode: "assets/algoritma.png",pin: "103",)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Algoritmalar ve Programlama",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Temel Bilgi Teknolojileri",qrCode: "assets/temelBilgi.png",pin: "104",)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Temel Bilgi Teknolojileri",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Ağ Yönetimi Ve Bilgi Güvenliği",qrCode: "assets/agYonetimi.png",pin: "105")));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Ağ Yönetimi Ve Bilgi Güvenliği",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>WebHomePage(courses: "Veritabanı Programlama",qrCode: "assets/veritabani.png",pin: "106",)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: Colors.white),
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: Center(
                  child: Text(
                    "Veritabanı Programlama",
                    style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
