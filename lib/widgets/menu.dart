import 'package:qr_exam_app/devices/phone/add_name.dart';
import 'package:qr_exam_app/devices/phone/exam_page.dart';
import 'package:qr_exam_app/mobile_scanner.dart';
import 'package:qr_exam_app/widgets/answer_box.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../services/db_services.dart';

class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  DBService dbService=DBService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _controller = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: HexColor("#41337A"),
      ),
      width: size.width * 0.65,
      height: size.height * 0.428,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: size.width * 0.04),
            child: Image(
              height: size.height * 0.12,
              image: AssetImage("assets/qrWhite.png.png"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(size.width * 0.02),
            child: Button(
              onPressed: () {
                Navigator.push(
                   context,
                    MaterialPageRoute(
                        builder: (context) => MobileScannerPage()));
              },
              text: "QR Kodu okut",
              color: HexColor("#6EA4BF"),
              width: size.width * 0.3,
              height: size.height * 0.06,
              radius: 30,
              fontSize: size.width * 0.037,
              textColor: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: size.width * 0.02),
            child: Text("Ya da",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04)),
          ),
          Container(
            padding: EdgeInsets.only(bottom: size.width * 0.025),
            child: SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.07,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4)),
                    filled: true,
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: size.width * 0.035),
                    hintText: "Sınav PIN'i gir.",
                    fillColor: Colors.white),
              ),
            ),
          ),
          Button(
            onPressed: () {
              getCourses().then((value){
                print(value);
              });
              //FocusManager.instance.primaryFocus.unfocus();
              Future.delayed(Duration(seconds: 1),(){
                /*if (_controller.text == "101") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Sistem Analizi Ve Tasarımı",pin: "101",)));
                }else if (_controller.text == "102") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Bilgisayar Ve Programlamaya Giriş",pin: "102",)));
                }else if (_controller.text == "103") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Algoritmalar ve Programlama",pin: "103",)));
                }else if (_controller.text == "104") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Temel Bilgi Teknolojileri",pin: "104",)));
                }else if (_controller.text == "105") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Ağ Yönetimi Ve Bilgi Güvenliği",pin: "105",)));
                }else if (_controller.text == "106") {
                  return Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ExamPage(courses: "Veritabanı Programlama",pin: "106",)));
                }*/
              });
            },
            text: "İleri",
            color: HexColor("#6EA4BF"),
            width: size.width * 0.3,
            height: size.height * 0.06,
            radius: 30,
            fontSize: size.width * 0.037,
            textColor: Colors.white
          ),
        ],
      ),
    );
  }
  Future getCourses() async {
    var courses = await dbService.allCourses();
    return courses;
  }
}
