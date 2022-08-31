import 'package:qr_exam_app/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:developer' as d;



class WebHomePage extends StatefulWidget {


  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
DBService dbService=DBService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: HexColor("#3F1A89"),
        appBar: AppBar(
          leadingWidth: size.width * 0.15,
          leading: Center(
              child: Text(
            "qrExam",
            style: TextStyle(
                fontSize: size.width * 0.034, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
          backgroundColor: HexColor("#391778"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  getCourses().then((value) {
                    d.log(value.toString());
                  });
                  /*
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WebExamPage(courses: widget.courses,)));*/
                },
                child: Text(
                  "BAŞLAT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.02,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  //color: Colors.red,
                  width: size.width * 0.5,
                  height: size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //color: Colors.amber,
                        child: Text(
                          "s",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: size.width * 0.2,
                      height: size.height * 0.2,
                      //color: Colors.yellow,
                      child: Center(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Sınav PIN'i:",
                                style: TextStyle(
                                    fontSize: size.width * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Center(
                              child: Text(
                                "widget.pin",
                                style: TextStyle(
                                    fontSize: size.width * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   /* Container(
                      //color: Colors.yellow,
                      width: size.width * 0.5,
                      height: size.height * 0.6,
                      child: Container(
                        child: Image(
                          alignment: Alignment.center,
                          image: AssetImage(widget.qrCode),
                        ),
                      ),
                    ),*/
                  ],
                )
              ],
            ),
          ],
        ));
  }

  Container studentName(Size size) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: size.width * 0.08,
        height: size.height * 0.08,
        child: Center(
            child: Text(
          "ebubekir",
          style: TextStyle(
              fontSize: size.width * 0.01,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        )));

  }
  Future getCourses() async {
    var courses = await dbService.allCourses();
    return courses;
  }
}
