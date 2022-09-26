import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/devices/phone/home_page.dart';
import 'package:qr_exam_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_exam_app/view/desktop/auth/desktop_login_view.dart';
import 'dart:developer' as d;

import 'package:qr_exam_app/view/mobile/auth/mobile_login_view.dart';


class DesktopRegister extends StatefulWidget {
  @override
  State<DesktopRegister> createState() => _DesktopRegisterState();
}

class _DesktopRegisterState extends State<DesktopRegister> {
  AuthService authService = AuthService();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: mainColor,
            )),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/register.png",
                height: 180,
                width: 180,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hemen Kayıt ol",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Öğrencilerin Eğlenerek Öğrensin",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: mailController,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      prefixIcon: Icon(
                        Icons.mail_outline,
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
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      prefixIcon: Icon(
                        Icons.lock_outline,
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
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordAgainController,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Şifre Tekrar',
                      prefixIcon: Icon(
                        Icons.lock,
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
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Ad',
                      prefixIcon: Icon(
                        Icons.person,
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
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: surnameController,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Soyad',
                      prefixIcon: Icon(
                        Icons.person_outline_sharp,
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
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.3, right: size.width*0.3),
                child: Container(
                  height: 50.0,
                  width: size.width,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      register(
                          mailController.text,
                          passwordController.text,
                          passwordAgainController.text,
                          nameController.text,
                          surnameController.text)
                          .then((s) {
                        if(s==200){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }else{
                          d.log(s.toString());
                        }
                      });
                    },
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: size.width, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Devam",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.width * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabın Var Mı?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DesktopLogin()));
                      },
                      child: Text("Hemen Giriş Yap",
                          style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future register(String mail, String password, String passAgain, String name,
      String surname) async {
    var user =
    await authService.register(mail, password, passAgain, name, surname);
    return user;
  }
}
