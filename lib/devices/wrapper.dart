import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'auth/login_view.dart';
import 'auth/web_login_view.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebLogin();
    } else {
      return Login();
    }
  }
}
