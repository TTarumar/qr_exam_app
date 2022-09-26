import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qr_exam_app/const/colors.dart';
import 'package:qr_exam_app/model/user_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:developer' as d;
import '../../viewModel/user_view_model.dart';

class MobileQuestion extends StatefulWidget {
  var question;
  var email;
  var userName;
  var lastName;
  var id;
  var courseTitle;

  MobileQuestion(
      this.question, this.email, this.userName, this.lastName, this.id,this.courseTitle);

  @override
  State<MobileQuestion> createState() => _MobileQuestionState();
}

class _MobileQuestionState extends State<MobileQuestion> {
  int point = 0;
  int indexQ = 0;
  List question = [];
  bool queGet = false;
  String answer = "";
  bool correctQuestion = false;
  var questionKey;
  var questionT;
  var answerKeys;
  int choice = 10;
  Map answerList;
  bool oA = false;
  bool oB = false;
  bool oC = false;
  bool oD = false;
  bool oE = false;
  List selectionList = [];
  List<String> pointList = [];

  var channel = WebSocketChannel.connect(
    Uri.parse('ws://10.14.1.50:8080'),
  );

  Future<void> getQuestion() async {
    await rootBundle.loadString("assets/question.json").then(
      (value) {
        for (int i = 0; i < value.length; i++) {
          if (json.decode(value)[i]["id"] == widget.question) {
            question = json.decode(value)[i]["question"];
            return question;
          }
        }
      },
    );
    return question;
  }

  @override
  void initState() {
    selectionList.insert(indexQ, "");
    pointList.insert(indexQ, "");

    d.log(widget.question.toString());
    waitingCheck();
    super.initState();
  }

  UserViewModel userViewModel;

  @override
  Widget build(BuildContext context) {
    userViewModel = Provider.of<UserViewModel>(context, listen: false);

/*
    getQuestions().then((value) {
      getAnswers().then((ss) {});
    });*/
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: StreamBuilder(
            stream: channel.stream,
            builder: (context, async) {
              if (async.connectionState == ConnectionState.waiting) {
                return Container(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: mainColor,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        "Öğretmeninizin Sınavı Başlatması Bekleniyor",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              } else {
                var socketMap = jsonDecode(async.data);
                if (socketMap["type"] == "waiting") {
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.courseTitle,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset("assets/lotties/waitingExam.json"),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          "Öğretmeninizin Sınavı Başlatması Bekleniyor",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                } else if (socketMap["type"] == "examStart") {
                  return Stack(
                    children: [
                      Container(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: size.width * 0.1,
                                  right: size.width * 0.06,
                                  left: size.width * 0.06),
                              child: Container(
                                child: Column(
                                  children: [
                                    indexQ == 10
                                        ? Container()
                                        : questionTitle(
                                            size, widget.question[indexQ]),
                                    SizedBox(
                                      height: size.width * 0.1,
                                    ),
                                    indexQ == 10
                                        ? Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.width * 0.2,
                                                ),
                                                Lottie.asset("assets/lotties/done.json",
                                                    height: size.width * 0.8),
                                                SizedBox(
                                                  height: size.width * 0.1,
                                                ),
                                                Text(
                                                  "Sınav Soruları Bitmiştir.",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          size.width * 0.05),
                                                )
                                              ],
                                            ),
                                          )
                                        : questionOption(widget.question[indexQ],
                                            context, size),
                                    SizedBox(
                                      height: size.width * 0.06,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 14.0, right: 14.0, top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (indexQ != 0) {
                                          print("burda");
                                          indexQ--;
                                          setState(() {});
                                        }
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: indexQ == 0
                                            ? Colors.grey
                                            : Colors.black,
                                      )),
                                  Expanded(
                                    child: StepProgressIndicator(
                                      totalSteps: 10,
                                      currentStep: indexQ,
                                      selectedColor: mainColor,
                                      unselectedColor: Colors.grey,
                                      size: size.width * 0.06,
                                      roundedEdges: Radius.circular(12),
                                      customStep: (index, color, _) =>
                                          color == mainColor
                                              ? Container(
                                                  color: color,
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: size.width * 0.045,
                                                  ),
                                                )
                                              : index == indexQ
                                                  ? Container(
                                                      color: color,
                                                      child: Icon(
                                                        Icons.circle_outlined,
                                                        size: size.width * 0.04,
                                                      ),
                                                    )
                                                  : Container(
                                                      color: color,
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: size.width * 0.04,
                                                      ),
                                                    ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (indexQ != 10) {
                                          print("burda");
                                          indexQ++;
                                          setState(() {});
                                        }
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: indexQ == 10
                                            ? Colors.grey
                                            : Colors.black,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    indexQ > 9
                                        ? "Soru" + "10/10"
                                        : "Soru" + " (${indexQ + 1}/10)",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: size.width * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            var sumPoint;
                            if (indexQ < 10) {
                              oA = false;
                              oB = false;
                              oC = false;
                              oD = false;
                              oE = false;
                              if (indexQ != 10) {
                                indexQ++;

                                var error = "";
                                try {
                                  if (selectionList[indexQ] == "" ||
                                      selectionList[indexQ] == "a" ||
                                      selectionList[indexQ] == "b" ||
                                      selectionList[indexQ] == "c" ||
                                      selectionList[indexQ] == "d" ||
                                      selectionList[indexQ] == "e") {
                                  } else {}
                                } catch (e) {
                                  print(e.toString() + " ddddd");
                                  error = e.toString();
                                }

                                if (error.contains("RangeError")) {
                                  selectionList.insert(indexQ, "");
                                  pointList.insert(indexQ, "");
                                }

                                setState(() {});
                              } else {}
                            } else {
                              var sum = 0;
/*
                              List<int> lint = pointList.map(int.parse).toList();
                            */ /*  sumPoint= lint.reduce((a, b) => a + b);*/
                              for (int i = 0; i < 10; i++) {
                                if (pointList[i] == null || pointList[i] == "") {
                                } else {
                                  sum += int.parse(pointList[i]);
                                }
                              }
                              sendPoint(sum);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            height: size.width * 0.12,
                            width: size.width,
                            child: Center(
                              child: Text(
                                indexQ != 10 ? "Sonraki Soru" : "Bitir ve Tamamla",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  var sum = 0;

                  for (int i = 0; i < 10; i++) {
                    if (pointList[i] == null || pointList[i] == "") {
                    } else {
                      sum += int.parse(pointList[i]);
                    }
                  }
                  return Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.width * 0.6),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Tebrikler",
                              style: TextStyle(
                                  fontSize: size.width * 0.08,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Lottie.asset("assets/succses.json",
                            height: size.width * 3, width: size.width * 3),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/man.png",
                            height: size.width * 0.35,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom: size.width*0.6),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text("Puanınız: ${sum}",style: TextStyle(fontSize: size.width*0.07,color: mainColor,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom: size.width*0.1),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text("Lütfen öğretmeninizin sınavı bitirmesini bekleyin.",style: TextStyle(fontSize: size.width*0.03,color: Colors.grey,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }),
      ),
    );
  }

  Future waitingCheck() async {
    Map<String, dynamic> map = {
      "type": "intoExam",
      "user": {
        "name": widget.userName,
        "id": widget.id,
      },
      "examID": "43"
    };
    channel.sink.add(jsonEncode(map));
  }

  Future sendPoint(var point) async {
    Map<String, dynamic> map = {
      "type": "resultExam",
      "user": {
        "name": widget.userName,
        "id": widget.id,
      },
      "point": point
    };
    channel.sink.add(jsonEncode(map));
  }

  Future getQuestions() async {
    for (int i = 0; i < 10; i++) {
      questionKey = await widget.question[0][i]["all_questions"].keys.first;
      questionT =
          await widget.question[0][i]["all_questions"][questionKey]["question"];
    }

    return questionTitle;
  }

  Widget questionTitle(Size size, Map map) {
    Map map1 = map["all_questions"];
    String key = map1.keys.toList().first.toString();
    var document = parse(map1[key]["question"].toString());
    var data = document.body.text.toString();
    var list = data.split(".");
    return Column(
      children: [
        SizedBox(
          height: size.width * 0.1,
        ),
        indexQ == 10
            ? Container(
                height: size.width * 0.2,
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: HtmlWidget(
                    list[0],
                  ),
                ),
              ),
      ],
    );
  }

/*
Flexible(
                    HtmlWidget(
                      keyOptions[list[1].toString()]["value"],
                      textStyle: TextStyle(
                          fontFamily: "poppinsMedium", color: Colors.black),
                    ),

*/
  Widget questionOption(Map map, context, Size size) {
    Map map1 = map["all_questions"];
    String keyQuestion = map1.keys.toList().first.toString();

    Map keyOptions = map1[keyQuestion]["answer_options"];

    List list = keyOptions.keys.toList();

    return Column(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: selectionList[indexQ] == "a" ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: InkWell(
              onTap: () {
                oB = false;
                oC = false;
                oD = false;
                oE = false;

                oA = !oA; //optionAnswer
                if (oA == false) {
                  //Şık işaretleme
                  selectionList.removeAt(indexQ);
                  selectionList.insert(indexQ, "");
                  //Puan ekleme
                  pointList.removeAt(indexQ);
                  pointList.insert(indexQ, "");

                  print(pointList.toString() + " Puan");
                } else {
                  //TODO: Burada kaldık indexteki şıkkı silmek için çalışıyoduk
                  if (selectionList.isNotEmpty) {
                    print("ss");
                    selectionList.removeAt(indexQ);
                    selectionList.insert(indexQ, "a");
                    pointList.removeAt(indexQ);
                    pointList.insert(
                        indexQ, keyOptions[list[0].toString()]["marks"]);
                  } else {
                    selectionList.insert(indexQ, "a");
                    pointList.insert(
                        indexQ, keyOptions[list[0].toString()]["marks"]);
                  }
                  print(pointList.toString() + " Puan");
                }

                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "a) ",
                    style: TextStyle(
                        color: selectionList[indexQ] == "a"
                            ? Colors.white
                            : Colors.black),
                  ),
                  Flexible(
                    child: HtmlWidget(
                      keyOptions[list[0].toString()]["value"],
                      textStyle: TextStyle(
                          color: selectionList[indexQ] == "a"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.width * 0.1,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: selectionList[indexQ] == "b" ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: InkWell(
              onTap: () {
                oA = false;
                oC = false;
                oD = false;
                oE = false;

                oB = !oB; //optionAnswer
                if (oB == false) {
                  selectionList.removeAt(indexQ);
                  selectionList.insert(indexQ, "");
                  pointList.removeAt(indexQ);
                  pointList.insert(indexQ, "");
                  print(pointList.toString() + " Puan");
                } else {
                  if (selectionList.isNotEmpty) {
                    selectionList.removeAt(indexQ);
                    selectionList.insert(indexQ, "b");
                    pointList.removeAt(indexQ);
                    pointList.insert(
                        indexQ, keyOptions[list[1].toString()]["marks"]);
                  } else {
                    selectionList.insert(indexQ, "b");
                    pointList.insert(
                        indexQ, keyOptions[list[1].toString()]["marks"]);
                  }
                  print(pointList.toString() + " Puan");
                }

                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "b) ",
                    style: TextStyle(
                        color: selectionList[indexQ] == "b"
                            ? Colors.white
                            : Colors.black),
                  ),
                  Flexible(
                    child: HtmlWidget(
                      keyOptions[list[1].toString()]["value"],
                      textStyle: TextStyle(
                          color: selectionList[indexQ] == "b"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.width * 0.1,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: selectionList[indexQ] == "c" ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: InkWell(
              onTap: () {
                oA = false;
                oB = false;
                oD = false;
                oE = false;

                oC = !oC; //optionAnswer
                if (oC == false) {
                  selectionList.removeAt(indexQ);
                  selectionList.insert(indexQ, "");
                  pointList.removeAt(indexQ);
                  pointList.insert(indexQ, "");
                  print(pointList.toString() + " Puan");
                } else {
                  //TODO: Burada kaldık indexteki şıkkı silmek için çalışıyoduk
                  if (selectionList.isNotEmpty) {
                    print("cc");
                    selectionList.removeAt(indexQ);
                    selectionList.insert(indexQ, "c");
                    pointList.removeAt(indexQ);
                    pointList.insert(
                        indexQ, keyOptions[list[2].toString()]["marks"]);
                  } else {
                    selectionList.insert(indexQ, "c");
                    pointList.insert(
                        indexQ, keyOptions[list[2].toString()]["marks"]);
                  }
                  print(pointList.toString() + " Puan");
                }
                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "c) ",
                    style: TextStyle(
                        color: selectionList[indexQ] == "c"
                            ? Colors.white
                            : Colors.black),
                  ),
                  Flexible(
                    child: HtmlWidget(
                      keyOptions[list[2].toString()]["value"],
                      textStyle: TextStyle(
                          color: selectionList[indexQ] == "c"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.width * 0.1,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: selectionList[indexQ] == "d" ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: InkWell(
              onTap: () {
                oA = false;
                oB = false;
                oC = false;
                oE = false;

                oD = !oD; //optionAnswer
                if (oD == false) {
                  selectionList.removeAt(indexQ);
                  selectionList.insert(indexQ, "");
                  pointList.removeAt(indexQ);
                  pointList.insert(indexQ, "");
                  print(pointList.toString() + " Puan");
                } else {
                  //TODO: Burada kaldık indexteki şıkkı silmek için çalışıyoduk
                  if (selectionList.isNotEmpty) {
                    print("dd");
                    selectionList.removeAt(indexQ);
                    selectionList.insert(indexQ, "d");

                    pointList.removeAt(indexQ);
                    pointList.insert(
                        indexQ, keyOptions[list[3].toString()]["marks"]);
                  } else {
                    selectionList.insert(indexQ, "d");
                    pointList.insert(
                        indexQ, keyOptions[list[3].toString()]["marks"]);
                  }
                  print(pointList.toString() + " Puan");
                }

                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "d) ",
                    style: TextStyle(
                        color: selectionList[indexQ] == "d"
                            ? Colors.white
                            : Colors.black),
                  ),
                  Flexible(
                    child: HtmlWidget(
                      keyOptions[list[3].toString()]["value"],
                      textStyle: TextStyle(
                          color: selectionList[indexQ] == "d"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.width * 0.1,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: selectionList[indexQ] == "e" ? mainColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.03),
            child: InkWell(
              onTap: () {
                oA = false;
                oB = false;
                oC = false;
                oD = false;

                oE = !oE; //optionAnswer
                if (oE == false) {
                  selectionList.removeAt(indexQ);
                  selectionList.insert(indexQ, "");
                  pointList.removeAt(indexQ);
                  pointList.insert(indexQ, "");
                  print(pointList.toString() + " Puan");
                } else {
                  //TODO: Burada kaldık indexteki şıkkı silmek için çalışıyoduk
                  if (selectionList.isNotEmpty) {
                    print("ee");
                    selectionList.removeAt(indexQ);
                    selectionList.insert(indexQ, "e");

                    pointList.removeAt(indexQ);
                    pointList.insert(
                        indexQ, keyOptions[list[4].toString()]["marks"]);
                  } else {
                    selectionList.insert(indexQ, "e");
                    pointList.insert(
                        indexQ, keyOptions[list[4].toString()]["marks"]);
                  }
                  print(pointList.toString() + " Puan");
                }
                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "e) ",
                    style: TextStyle(
                        color: selectionList[indexQ] == "e"
                            ? Colors.white
                            : Colors.black),
                  ),
                  Flexible(
                    child: HtmlWidget(
                      keyOptions[list[4].toString()]["value"],
                      textStyle: TextStyle(
                          color: selectionList[indexQ] == "e"
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.width * 0.09,
        ),
      ],
    );
  }

  Future getAnswers() async {
    answerKeys = await widget
        .question[0][indexQ]["all_questions"][questionKey]["answer_options"]
        .keys
        .toList();
    /*for(int i =0;i<=4 ;i++){
      answerList.addAll(widget.question[0][0]["all_questions"][questionKey]["answer_options"][answerKeys[i]]);
    }*/
    print(widget.question[0][indexQ]["all_questions"][questionKey]
        ["answer_options"][answerKeys[0]]);
    print(widget.question[0][indexQ]["all_questions"][questionKey]
        ["answer_options"][answerKeys[1]]);
    print(widget.question[0][indexQ]["all_questions"][questionKey]
        ["answer_options"][answerKeys[2]]);
    print(widget.question[0][indexQ]["all_questions"][questionKey]
        ["answer_options"][answerKeys[3]]);
    print(widget.question[0][indexQ]["all_questions"][questionKey]
        ["answer_options"][answerKeys[4]]);
  }
}
/*
*/
