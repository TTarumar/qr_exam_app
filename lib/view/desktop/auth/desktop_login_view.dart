import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/devices/web/home_page.dart';
import 'package:qr_exam_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as d;

import 'package:qr_exam_app/view/desktop/auth/desktop_register_view.dart';
import 'package:qr_exam_app/view/desktop/desktop_courses_view.dart';
import 'package:qr_exam_app/view/desktop/desktop_home_view.dart';

import '../../../viewModel/user_view_model.dart';

class DesktopLogin extends StatefulWidget {
  @override
  State<DesktopLogin> createState() => _DesktopLoginState();
}

class _DesktopLoginState extends State<DesktopLogin> {
  AuthService authService = AuthService();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding:  EdgeInsets.only(right:20.0),
            child: Row(
              children: [
                Text(
                  "qr",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: size.width * 0.02,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Exam",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.02,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
        leading: SizedBox(
          height: size.width*0.02,
          width: size.width*0.02,
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            hoverColor: Colors.grey[100],
            padding: new EdgeInsets.all(0.0),
            color: mainColor,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                    right: size.width * 0.35, left: size.width * 0.35,top: size.width*0.04),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      "assets/login.svg",
                      height: size.width * 0.14,
                      width: size.width * 0.14,
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    Container(
                      width: size.width * 0.27,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hoşgeldiniz",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Yarışmalar ile kendini geliştirmeye hazır mısın?",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width * 0.02),
                    Container(
                      height: size.height * 0.065,
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
                    SizedBox(height: 30),
                    Container(
                      height: size.height * 0.065,
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
                    SizedBox(height: size.width * 0.01),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 40.0,
                      width: size.width,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          login("ogrenci1@qulak.com", "123456Kc").then((value) {
                            if (value !=null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesktopCourses()));
                            } else {
                              d.log(value.toString());
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
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabın Yok Mu?",
                          style: TextStyle(fontSize: size.width * 0.013),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesktopRegister()));
                            },
                            child: Text("Hemen Kayıt Ol",
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.013))),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future login(String mail, String password) async {
    var user = await userViewModel.login(mail, password);
    return user;
  }
}