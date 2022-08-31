import 'dart:convert';
import 'dart:developer' as d;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:string_splitter/string_splitter.dart';
import '../const/api.dart';
import '../model/user_model.dart';
import 'auth_base.dart';

class AuthService implements AuthBase {

  @override
  Future<bool> login(String email, String pass) async {
    final response = await http.post(
      Uri.parse('$companyUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({'email': email, 'password': pass}),
    );
    var newList=[];
    d.log(response.headers["set-cookie"].toString());

    var cookie = response.headers["set-cookie"].toString();
      for(int i =0;i<= cookie.length-1;i++){
        if(cookie[i]==";"){
          break;
        }else
          newList.add(cookie[i]);
      }
      var newString = newList.toString().replaceAll(",", '').toString();
      var newStringWithoutBlank = newString.replaceAll(" ", '').toString();
      var newStringBlanket = newStringWithoutBlank.replaceAll("[", '').toString();
      var newStringResult = newStringBlanket.replaceAll("]", '').toString();
      loginCookie = newStringResult;


    d.log(loginCookie);


    var userJson = jsonDecode(response.body)["user"];


    UserModel _userModelObject = UserModel.fromMap(userJson);
    if (response.statusCode == 200) {
      return true;
    } else {
      d.log(userJson["message"]);
      return false;
    }
  }

  @override
  Future<dynamic> register(
      String email,
      String password,
      String passwordConfirmation,
      String firstName,
      String lastName,
      ) async {
    final response = await http.post(
      Uri.parse('$companyUrl/api/usercreateapi'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'first_name': firstName,
        'last_name': lastName
      }),
    );
    loginCookie = response.headers["set-cookie"].toString();
    if (response.statusCode == 200) {
      Map<String, dynamic> _readingValuesMap = json.decode(response.body);
      UserModel _userModelObject = UserModel.fromMap(_readingValuesMap);

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

/*
  @override
  Future<dynamic> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    return response;
  }*/
}