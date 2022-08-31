import 'dart:convert';

import 'package:qr_exam_app/devices/web/result_page.dart';
import 'package:qr_exam_app/widgets/answer_box.dart';
import 'package:qr_exam_app/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class WebExamPage extends StatefulWidget {
  final String courses;
  const WebExamPage({Key key, this.courses}) : super(key: key);

  @override
  State<WebExamPage> createState() => _WebExamPageState();
}
class _WebExamPageState extends State<WebExamPage> {
  int point = 0;
  String answer = "";
  bool correctQuestion = false;
  List question=[];
  int index=0;
  bool queGet=false;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestion().whenComplete(() =>setState((){
      question;
      queGet=true;
    }));
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: HexColor("#391778"),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Text(
                  widget.courses,
                  style: TextStyle(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              queGet?Column(children: [
                Row(
                  children: [
                    SizedBox(width: size.width * 0.2, height: size.height * 0.15),
                    /*Timer(
                      width: size.width * 0.1,
                      height: size.height * 0.15,
                      index: (){
                        setState(() {
                          index++;
                        });
                      },count: 10,
                    ),*/
                    SizedBox(width: size.width * 0.025),
                    Container(
                      height: size.height * 0.3,
                      width: size.width * 0.55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          question[index]["title"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.015,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Column(
                      children: [
                        Button(
                          width: size.width * 0.1,
                          height: size.height * 0.05,
                          radius: 5,
                          fontSize: size.width * 0.01,
                          text: "İleri",
                          onPressed: () {
                            setState(() {
                              answer="";
                              if(correctQuestion){
                                point=point+10;
                              }
                              if(index==9){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebResultPage(point: point,)));
                              }else{
                                index++;
                              }
                            });
                          },
                          color: Colors.white,
                          textColor: Colors.black,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          "Soru" + "(${index+1},${question.length})",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      width: size.width * 0.475,
                      height: size.height * 0.15,
                      radius: 0,
                      fontSize: size.width * 0.012,
                      text: "A) ${question[index]["answer_options"][0]["value"]}",
                      onPressed: () {
                        setState(() {
                          answer=question[index]["answer_options"][0]["value"];
                          correctQuestion=question[index]["answer_options"][0]["marks"];
                        });
                      },
                      color:answer==question[index]["answer_options"][0]["value"]?Colors.amber:Colors.white,
                    ),
                    SizedBox(width: size.width * 0.009),
                    Button(
                      width: size.width * 0.475,
                      height: size.height * 0.15,
                      radius: 0,
                      fontSize: size.width * 0.012,
                      text: "B) ${question[index]["answer_options"][1]["value"]}",
                      onPressed: () {
                        setState(() {
                          answer=question[index]["answer_options"][1]["value"];
                          correctQuestion=question[index]["answer_options"][1]["marks"];
                        });
                      },
                      color:answer==question[index]["answer_options"][1]["value"]?Colors.amber:Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      width: size.width * 0.475,
                      height: size.height * 0.15,
                      radius: 0,
                      fontSize: size.width * 0.012,
                      text: "C) ${question[index]["answer_options"][2]["value"]}",

                      onPressed: () {
                        setState(() {
                          answer=question[index]["answer_options"][2]["value"];
                          correctQuestion=question[index]["answer_options"][2]["marks"];
                        });
                      },
                      color:answer==question[index]["answer_options"][2]["value"]?Colors.amber:Colors.white,
                    ),
                    SizedBox(width: size.width * 0.009),
                    Button(
                        width: size.width * 0.475,
                        height: size.height * 0.15,
                        radius: 0,
                        fontSize: size.width * 0.012,
                        text: "D) ${question[index]["answer_options"][3]["value"]}",

                        onPressed: () {
                          setState(() {
                            answer=question[index]["answer_options"][3]["value"];
                            correctQuestion=question[index]["answer_options"][3]["marks"];
                          });
                        },
                      color:answer==question[index]["answer_options"][3]["value"]?Colors.amber:Colors.white,
                    )],
                ),
                SizedBox(height: size.height * 0.015),
                Button(
                    width: size.width * 0.45,
                    height: size.height * 0.15,
                    radius: 0,
                    fontSize: size.width * 0.012,
                    text: "E) ${question[index]["answer_options"][4]["value"]}",

                    onPressed: () {
                      setState(() {
                        answer=question[index]["answer_options"][4]["value"];
                        correctQuestion=question[index]["answer_options"][4]["marks"];
                      });
                    },
                  color:answer==question[index]["answer_options"][4]["value"]?Colors.amber:Colors.white,
                ),
              ],):Center(child: CircularProgressIndicator(),)
            ],
          ),
        ));
  }

  Future<void> getQuestion() async {
   await rootBundle.loadString("assets/question.json").then((value) {
     for(int i=0;i<json.decode(value).length;i++){
       if(json.decode(value)[i]["name"]==widget.courses){
         question=json.decode(value)[i]["question"];
         return question;
       }
     }
   });
 return question;
 }
}
