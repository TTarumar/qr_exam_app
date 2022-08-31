import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../widgets/answer_box.dart';
import 'loading_screen.dart';

class AddName extends StatefulWidget {
  const AddName({Key key}) : super(key: key);

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.28),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HexColor("#41337A"),
                ),
                width: size.width * 0.6,
                height: size.height * 0.22,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: size.width * 0.08),
                      child: SizedBox(
                        width: size.width * 0.5,
                        height: size.height * 0.07,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width * 0.038,
                              ),
                              hintText: "Adını gir.",
                              fillColor: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: size.width * 0.04),
                      child: Button(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadingScreen()));
                        },
                        text: "İleri",
                        color: HexColor("#6EA4BF"),
                        width: size.width * 0.3,
                        height: size.height * 0.06,
                        radius: 30,
                        fontSize: size.width * 0.037,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
