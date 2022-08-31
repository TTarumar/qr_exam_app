// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:qr_exam_app/devices/phone/result_page.dart';
import 'package:qr_exam_app/widgets/answer_box.dart';
import 'package:qr_exam_app/widgets/question_box.dart';
import 'package:qr_exam_app/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/db_services.dart';


class ExamPage extends StatefulWidget {
  final String courses;
  final String pin;



  const ExamPage({Key key, this.courses, this.pin}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  DBService dbService=DBService();

  int point = 0;
  int index=0;
  List question=[];
  bool queGet=false;
  String answer="";
  bool correctQuestion=false;



  Future<void> getQuestion() async {
    await rootBundle.loadString("assets/question.json").then((value) {
      for(int i=0;i<value.length;i++){
        if(json.decode(value)[i]["name"]==widget.courses){
          question=json.decode(value)[i]["question"];
          return question;
      }
    }    });
      return question;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestion().whenComplete((){
      setState(() {
        queGet=true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body:
      queGet?question.isEmpty?Center(
        child: Text("Soru Bulunamadı"),
      ):Column(
        children: [
          AppBar(
            backgroundColor: HexColor("#41337A"),
            title: Text(
              widget.courses,
              style: TextStyle(color: Colors.white, fontSize: size.width * 0.045),
            ),
          ),Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: size.width * 0.02),
                  width: size.width * 0.25,
                  height: size.height * 0.06,
                  child: Center(
                    child: Text(
                      "Soru" + "(${index+1},${question.length})",
                      style: TextStyle(color: Colors.black, fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),



                /*Container(
              padding: EdgeInsets.only(top: size.width * 0.05),
              child: Timer(
                width: size.width * 0.2,
                height: size.height * 0.08,
                index: (){
                  setState(() {
                    index++;
                  });

                },
                count: 10,
              ),
            ),*/

            Container(
              padding: EdgeInsets.only(top: size.width * 0.03),
              child: QuestionBox(
                question:
                question[index]["title"],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.width * 0.03),
              child: Button(
                color:answer==question[index]["answer_options"][0]["value"]?Colors.amber:HexColor("#6EA4BF"),
                width: size.width * 0.8,
                height: size.height * 0.07,
                radius: 10,
                fontSize: size.width * 0.035,
                text: "A) ${question[index]["answer_options"][0]["value"]}",
                onPressed: () {
                  setState(() {
                    answer=question[index]["answer_options"][0]["value"];
                    correctQuestion=question[index]["answer_options"][0]["marks"];
                  });
                },
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.width * 0.02),
              child: Button(
                width: size.width * 0.8,
                height: size.height * 0.07,
                radius: 10,
                fontSize: size.width * 0.035,
                text: "B) ${question[index]["answer_options"][1]["value"]}",
                onPressed: () {
                  setState(() {
                    answer=question[index]["answer_options"][1]["value"];
                    correctQuestion=question[index]["answer_options"][1]["marks"];
                  });
                },
                color:answer==question[index]["answer_options"][1]["value"]?Colors.amber:HexColor("#6EA4BF"),
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.width * 0.02),
              child: Button(
                width: size.width * 0.8,
                height: size.height * 0.07,
                radius: 10,
                fontSize: size.width * 0.035,
                text: "C) ${question[index]["answer_options"][2]["value"]}",
                onPressed: () {
                  setState(() {
                    answer=question[index]["answer_options"][2]["value"];
                    correctQuestion=question[index]["answer_options"][2]["marks"];
                  });
                },
                color:answer==question[index]["answer_options"][2]["value"]?Colors.amber:HexColor("#6EA4BF"),
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.width * 0.02),
              child: Button(
                width: size.width * 0.8,
                height: size.height * 0.07,
                radius: 10,
                fontSize: size.width * 0.035,
                text: "D) ${question[index]["answer_options"][3]["value"]}",
                onPressed: () {
                  setState(() {
                    answer=question[index]["answer_options"][3]["value"];
                    correctQuestion=question[index]["answer_options"][3]["marks"];
                  });
                },
                color:answer==question[index]["answer_options"][3]["value"]?Colors.amber:HexColor("#6EA4BF"),
                textColor: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: size.width * 0.02),
              child: Button(
                width: size.width * 0.8,
                height: size.height * 0.07,
                radius: 10,
                fontSize: size.width * 0.035,
                text: "E) ${question[index]["answer_options"][4]["value"]}",
                onPressed: () {
                  setState(() {
                    answer=question[index]["answer_options"][4]["value"];
                    correctQuestion=question[index]["answer_options"][4]["marks"];
                  });
                },
                color:answer==question[index]["answer_options"][4]["value"]?Colors.amber:HexColor("#6EA4BF"),
                textColor: Colors.white,
              ),
            ),
                Container(
                  padding: EdgeInsets.only(top: size.width * 0.02),
                  child:
                Button(
                  onPressed: (){
                    setState(() {

                     /* answer="";
                      if(correctQuestion){
                        point=point+10;

                      }
                      if(index==9){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultPage(point: point,)));
                      }else{
                        index++;
                      }*/

                    });
                  },
                  color: HexColor("#41337A"),
                  text: "İleri",
                  height: size.height * 0.05,
                  width: size.width * 0.3,
                  radius: 12,
                  textColor: Colors.white,
                ),),
              ],)
          ),
        ],
      ):Center(child: CircularProgressIndicator(),),
    );
  }
}
