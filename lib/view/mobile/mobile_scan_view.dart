import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qr_exam_app/model/user_model.dart';
import 'package:qr_exam_app/services/db_services.dart';
import 'package:qr_exam_app/view/mobile/mobile_home_view.dart';
import 'package:qr_exam_app/view/mobile/mobile_question_view.dart';
import 'package:qr_exam_app/viewModel/user_view_model.dart';

import '../../const/colors.dart';
import 'dart:developer' as d;

class Scan extends StatefulWidget {
  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcode = 'Unknown';
  DBService dbService = DBService();
  TextEditingController codeController = TextEditingController();
  UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: false);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 3.0),
          child: Row(
            children: [
              Text(
                "qr",
                style: TextStyle(
                    color: mainColor,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Exam",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                border: Border.all(color: mainColor),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: MobileHome(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Çıkış Yap",
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.03),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Qr Kodu Tara",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border: Border.all(color: mainColor)),
                  width: size.width * 0.55,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.qr_code_2_sharp,
                              color: mainColor,
                            ),
                            Icon(
                              Icons.qr_code_2_sharp,
                              color: mainColor,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          /*getCourseSubject(14).then((subjects){
                              d.log(subjects.toString());
                            });
*/
                          scanQR().then(
                            (value) {
                              getCourseQuestion(int.parse(_scanBarcode)).then(
                                (subjects) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MobileQuestion(
                                          subjects,
                                          userViewModel.userModel.email,
                                          userViewModel.userModel.name,
                                          userViewModel.userModel.last_name,
                                          userViewModel.userModel.id,
                                          ""),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: mainColor,
                              size: size.width * 0.25,
                            ),
                            Text(
                              "Tıkla",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.qr_code_2_sharp,
                              color: mainColor,
                            ),
                            Icon(
                              Icons.qr_code_2_sharp,
                              color: mainColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Text(
                "Veya",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.width * 0.04,
              ),
              Text(
                "Kodu Gir",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              Container(
                height: size.height * 0.065,
                width: size.width * 0.55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: codeController,
                  cursorColor: mainColor,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'Kod',
                    prefixIcon: Icon(
                      Icons.code,
                      color: mainColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.03,
              ),
              InkWell(
                onTap: () {
                  print("bastı");
                  getCourseQuestion(43
                          /*int.parse(
                      codeController.text.replaceAll("qlk", ""),
                    ),*/
                          )
                      .then(
                    (subjects) {
                      print(subjects);
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobileQuestion(subjects,userViewModel.userModel.email,userViewModel.userModel.name,userViewModel.userModel.last_name,userViewModel.userModel.id,""),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: size.width * 0.53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: mainColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Başla",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getCourseSubject(int id) async {
    var subjects = await dbService.getCourseSubject(id);
    return subjects;
  }

  Future getCourseQuestion(int id) async {
    var subjects = await dbService.getCourseSubjectQuestion(id);
    return subjects;
  }

  Future getCourses() async {
    var courses = await dbService.allCourses();
    return courses;
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff62d42f', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(
      () {
        _scanBarcode = barcodeScanRes;
      },
    );
  }
}
