import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../const/colors.dart';

class TimerView extends StatefulWidget {
  String courseTitle;
  int courseId;
  var userId;

  TimerView(this.courseTitle, this.courseId, this.userId);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  var channel = WebSocketChannel.connect(
    Uri.parse('ws://10.14.1.50:8080'),
  );

  @override
  void initState() {
    Map<String, dynamic> map = {
      "type": "init",
      "user": {
        "id": widget.userId,
      },
    };
    channel.sink.add(jsonEncode(map));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userId);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: channel.stream,
          builder: (context, async) {
            if (async.connectionState == ConnectionState.waiting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                    child: Container(
                      width: size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            widget.courseTitle,
                            style: TextStyle(
                                color: mainColor,
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            "Sağ taraftaki QR kodu okutarak veya gösterilen kodu girerek sınava başlayabilirsiniz\nKurallar\n1- Sınav sırasında sınavdan çıkmanız durumunda sınava girmemiş sayılacaksınız.\n2- Sınavınız devam ederken diğer öğrencilerin sınavına müdahale etmeniz veya iletişime geçmeniz sınavınızın iptal edilmesine neden olacaktır.\n3- Sınavınızı tamamladıktan sonra diğer öğrencilere müdahale etmeniz sınavınızın iptal edilmesine neden olacaktır. Sınavı tamamladıktan sonra öğretmeninizin sınavı bitirmesini bekleyiniz.",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: size.width * 0.012,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.width * 0.045,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  /*Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: QuestionView(widget.courseId),
                                    ),
                                  );*/
                                },
                                child: Container(
                                  height: size.width * 0.03,
                                  width: size.width * 0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: Colors.transparent,
                                      border: Border.all(color: mainColor)),
                                  child: Center(
                                    child: Text(
                                      "Sınavı Çöz",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  examStart();

                                  setState(() {});
                                },
                                child: Container(
                                  height: size.width * 0.03,
                                  width: size.width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: mainColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sınavı Başlat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*ListView.builder(
                    itemCount:
                        async.data["enteredExam"].length == null ? 0 : async.data.length,
                    itemBuilder: (context, index) {
                      return Card();
                    },
                  ),*/
                  Padding(
                    padding:
                        EdgeInsets.only(right: size.width * 0.12, top: 30.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        Text(
                          "QR Code",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                        QrImage(
                          data: widget.courseId.toString(),
                          version: QrVersions.auto,
                          size: size.width * 0.2,
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                height: 1,
                                width: 70),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Ya da",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: size.width * 0.025,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                height: 1,
                                width: 70),
                          ],
                        ),
                        Text(
                          "qlk" + widget.courseId.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            else if(async.data.toString().contains("students")){
              Map finished = jsonDecode(async.data);
              print(finished);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                    child: Container(
                      width: size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            widget.courseTitle,
                            style: TextStyle(
                                color: mainColor,
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text(
                            "Sağ taraftaki QR kodu okutarak veya gösterilen kodu girerek sınava başlayabilirsiniz\nKurallar\n1- Sınav sırasında sınavdan çıkmanız durumunda sınava girmemiş sayılacaksınız.\n2- Sınavınız devam ederken diğer öğrencilerin sınavına müdahale etmeniz veya iletişime geçmeniz sınavınızın iptal edilmesine neden olacaktır.\n3- Sınavınızı tamamladıktan sonra diğer öğrencilere müdahale etmeniz sınavınızın iptal edilmesine neden olacaktır. Sınavı tamamladıktan sonra öğretmeninizin sınavı bitirmesini bekleyiniz.",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: size.width * 0.012,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.width * 0.045,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  /*Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: QuestionView(widget.courseId),
                                    ),
                                  );*/
                                },
                                child: Container(
                                  height: size.width * 0.03,
                                  width: size.width * 0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      color: Colors.transparent,
                                      border: Border.all(color: mainColor)),
                                  child: Center(
                                    child: Text(
                                      "Sınavı Çöz",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  examStart();

                                  setState(() {});
                                },
                                child: Container(
                                  height: size.width * 0.03,
                                  width: size.width * 0.13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: mainColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sınavı Başlat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.01),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                      finished["students"].length == null ? 0 : finished["students"].length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Text(finished["students"][index]["name"]),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: size.width * 0.12, top: 30.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.width * 0.02,
                        ),
                        Text(
                          "QR Code",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                        QrImage(
                          data: widget.courseId.toString(),
                          version: QrVersions.auto,
                          size: size.width * 0.2,
                        ),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                height: 1,
                                width: 70),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Ya da",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: size.width * 0.025,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                ),
                                height: 1,
                                width: 70),
                          ],
                        ),
                        Text(
                          "qlk" + widget.courseId.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            else {
              Map finished = jsonDecode(async.data);
              print(finished);
              if (finished["type"] == "running") {
                print(finished);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Bitirenler",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: finished.length,
                              itemBuilder: (context, index) {
                                return finished["type"] == null
                                    ? Container(
                                        width: size.width * 0.2,
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.courseTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.02),
                          ),
                          Text(
                            "Kalan Süre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.02,
                                color: mainColor),
                          ),
                          Center(
                            child: SlideCountdownSeparated(
                              duration: Duration(minutes: 10),
                              height: size.width * 0.1,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              separatorStyle: TextStyle(
                                  color: mainColor,
                                  fontSize: size.width * 0.02),
                              textStyle: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              onDone: () {},
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              examFinish();
                              /* Navigator.pop(context);*/
                            },
                            child: Container(
                              height: size.width * 0.034,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  "Sınavı Bitir ve Liderlik Tablosunu Göster",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.01),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Bitirenler",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: finished.length - 1,
                              itemBuilder: (context, index) {
                                return finished["type"] == null
                                    ? Container(
                                        width: size.width * 0.2,
                                      )
                                    : Card(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(size.width * 0.01),
                                          child: Row(
                                            children: [
                                              Icon(Icons.person),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              Text(finished == null
                                                  ? ""
                                                  : finished["result"][index]
                                                      ["name"]),
                                              SizedBox(
                                                width: size.width * 0.1,
                                              ),
                                              Text(
                                                finished == null
                                                    ? "0 puan"
                                                    : finished["result"][index]
                                                        ["point"],
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              else if(finished["type"] == "finishedStudent"){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Bitirenler",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: finished.length-1,
                              itemBuilder: (context, index) {
                                return finished["type"] == null
                                    ? Container(
                                  width: size.width * 0.2,
                                )
                                    : Card(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.all(size.width * 0.01),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        Text(finished == null
                                            ? ""
                                            : finished["result"][0]
                                        ["name"]),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Text(
                                          finished == null
                                              ? "0 puan"
                                              : finished["result"][0]
                                          ["point"].toString(),
                                          style: TextStyle(
                                              color: mainColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.courseTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.02),
                          ),
                          Text(
                            "Kalan Süre",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.02,
                                color: mainColor),
                          ),
                          Center(
                            child: SlideCountdownSeparated(
                              duration: Duration(minutes: 10),
                              height: size.width * 0.1,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              separatorStyle: TextStyle(
                                  color: mainColor,
                                  fontSize: size.width * 0.02),
                              textStyle: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              onDone: () {},
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              examFinish();
                              /* Navigator.pop(context);*/
                            },
                            child: Container(
                              height: size.width * 0.034,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  "Sınavı Bitir ve Liderlik Tablosunu Göster",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.01),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              "Bitirenler",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: finished.length - 1,
                              itemBuilder: (context, index) {
                                return finished["type"] == null
                                    ? Container(
                                  width: size.width * 0.2,
                                )
                                    : Card(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.all(size.width * 0.01),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        Text(finished == null
                                            ? ""
                                            : finished["result"][0]
                                        ["name"]),
                                        SizedBox(
                                          width: size.width * 0.1,
                                        ),
                                        Text(
                                          finished == null
                                              ? "0 puan"
                                              : finished["result"][0]
                                          ["point"].toString(),
                                          style: TextStyle(
                                              color: mainColor,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              else {
                Map finished = jsonDecode(async.data);
                print(finished);
                finished["result"].sort((m1, m2) {
                  var r = m1["point"].compareTo(m2["point"]);
                  if (r != 0) return r;
                  return m1["point"].compareTo(m2["point"]);
                });
                return Container(
                  color: Colors.grey,
                );
              }
            }
          },
        ));
  }

  examStart() {
    Map<String, dynamic> map = {
      "type": "examStart",
      "user": {
        "id": widget.userId,
      },
    };
    channel.sink.add(jsonEncode(map));
  }

  examFinish() {
    Map<String, dynamic> map = {
      "type": "examFinish",
    };
    channel.sink.add(jsonEncode(map));
  }
}
