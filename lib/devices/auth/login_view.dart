import 'package:qr_exam_app/devices/auth/register_view.dart';
import 'package:qr_exam_app/devices/phone/home_page.dart';
import 'package:qr_exam_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as d;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService authService= AuthService();

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/login.png",
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hoşgeldiniz",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.width * 0.1,
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
              SizedBox(height: 30),
              Padding(
                padding:  EdgeInsets.only(left: 20.0,right: 20),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: mailController,
                    cursorColor: Colors.blue[800],
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Colors.blue[800],
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding:  EdgeInsets.only(left: 20.0,right: 20),
                child: Container(
                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    cursorColor: Colors.blue[800],
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.blue[800],
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 20.0,top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Text("Şifremi Unuttum",style: TextStyle(color: Colors.grey),),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding:  EdgeInsets.only(left: 20.0,right: 20),
                child: Container(
                  height: 50.0,
                  width: size.width,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: (){
                      login("btarumar@gmail.com", "Bthn.99").then((value) {
                        if(value==true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }else{
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
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: size.width, minHeight: 50.0),
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
              SizedBox(height: size.width*0.3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hesabın Yok Mu?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                      },
                      child: Text("Hemen Kayıt Ol", style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future login(String mail,String password) async {
   var user = await authService.login(mail, password);
   return user;
  }
}
