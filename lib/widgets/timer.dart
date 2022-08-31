import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:qr_exam_app/devices/phone/result_page.dart';
import 'package:qr_exam_app/devices/web/result_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class Timer extends StatefulWidget {
  final double width;
  final double height;
  final Function index;
  final int count;

  const Timer({Key key, this.width, this.height, this.index, this.count}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  final CountDownController _controller = CountDownController();
  Function index;
  int _duration;
  @override
  Widget build(BuildContext context) {
     index=widget.index;_duration=widget.count;
    Size size = MediaQuery.of(context).size;
    return CircularCountDownTimer(
      controller: _controller,
      width: widget.width,
      height: widget.height,
      duration: _duration,
      fillColor: HexColor("#41337A"),
      ringColor: HexColor("#6EA4BF"),
      onComplete: sayfaDegistir,
      isReverse: true,
    );
  }

  void sayfaDegistir() {
    if (kIsWeb) {
      index();
      _controller.reset();

    } else {
index();
_controller.reset();
    }
  }
}
