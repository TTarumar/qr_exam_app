import 'package:qr_exam_app/devices/phone/add_name.dart';
import 'package:qr_exam_app/devices/phone/exam_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScannerPage extends StatefulWidget {
  const MobileScannerPage({Key key}) : super(key: key);

  @override
  State<MobileScannerPage> createState() => _MobileScannerPageState();
}

class _MobileScannerPageState extends State<MobileScannerPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#41337A"),
        title: Text("QR Code"),
      ),
      body: MobileScanner(
        controller: cameraController,
        allowDuplicates: false,
        onDetect: foundCode,
      ),
    );
  }

  void foundCode(Barcode barcode, MobileScannerArguments arguments) {
    dynamic code = barcode.rawValue;
    FocusManager.instance.primaryFocus.unfocus();
    Future.delayed(Duration(seconds: 1), () {
      if (code.toString() == "Sistem Analizi Ve Tasarımı") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ExamPage(courses: "Sistem Analizi Ve Tasarımı")));
      } else {
        if (code.toString() == "Bilgisayar Ve Programlamaya Giriş") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExamPage(courses: "Bilgisayar Ve Programlamaya Giriş")));
        }
        if (code.toString().contains("Algoritmalar ve Programlama")) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExamPage(courses: "Algoritmalar ve Programlama")));
        }
        if (code.toString() == "Temel Bilgi Teknolojileri") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExamPage(courses: "Temel Bilgi Teknolojileri")));
        }
        if (code.toString() == "Ağ Yönetimi Ve Bilgi Güvenliği") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExamPage(courses: "Ağ Yönetimi Ve Bilgi Güvenliği")));
        }
        if (code.toString() == "Veritabanı Programlama") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExamPage(courses: "Veritabanı Programlama")));
        }
      }
    });
    //_launchUrl(code);
  }
}
