import 'dart:convert';

import 'package:http/http.dart' as http;
import '../const/api.dart';
import 'db_base.dart';

class DBService implements DBBase {
  @override
  Future allCourses() async {
    final response = await http.get(
      Uri.parse(companyUrl + '/admin/quizapp/courses'),
      headers: {'Accept': 'application/json', 'Cookie': loginCookie},
    );
    return json.decode(response.body);
  }

  @override
  Future getCourseSubject(int id) async {
    final response = await http.get(
      Uri.parse(companyUrl + '/admin/quizapp/course_subject/$id'),
      headers: {'Accept': 'application/json', 'Cookie': loginCookie},
    );
    return List<Map>.from(json.decode(response.body));
  }

  @override
  Future getCourseSubjectQuestion(int id) async {
    final response = await http.get(
      Uri.parse(companyUrl + '/admin/quizapp/subject_question/$id'),
      headers: {'Accept': 'application/json', 'Cookie': loginCookie},
    );
    return List<Map>.from(json.decode(response.body));
  }

/* @override
  Future getDailyTestsQuestion(int id) async {
    final response = await http.post(
      Uri.parse(companyUrl + '/api/quizapp/homework/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    if (userJson.toString() == "no_exam_questions") {
      return [];
    } else {
      return userJson;
    }
  }

  @override
  Future userCoinHistoryAdd(
      int id,
      int coins,
      int points,
      int questions,
      int trueQuestions,
      int falseQuestions,
      int emptyQuestions,
      String seconds) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory/new'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
      body: jsonEncode({
        'user_id': id,
        'coins': coins,
        'points': points,
        'questions': questions,
        'true_questions': trueQuestions,
        'false_questions': falseQuestions,
        'empty_questions': emptyQuestions,
        'seconds': seconds
      }),
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> notification() async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/notifications/user/notification'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> readNotification(String id) async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/notifications/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> questionOneVsOne() async {
    final response = await http.get(
      Uri.parse('$companyLogin/api/quizapp/quizappexam/question/seven'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> addFavoriteQuestion(int id) async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapptest/favorite_question/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> favoriteQuestionSubject() async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapptest/get_subject'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> favoriteQuestionLesson() async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapptest/get_course'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> favoriteQuestion() async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapptest/get_favorite_question'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> questionBankSubject() async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapp/all/subject'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);

    return userJson;
  }

  @override
  Future<dynamic> deleteFavoriteQuestion(int id) async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/quizapptest/delete_favorite_question/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> attemptQuestion(String id) async {
    final response = await http.get(
      Uri.parse('$companyLogin/admin/create_quiz_app_test/test_api/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    print(userJson.toString());
    return userJson;
  }

  @override
  Future<dynamic> leadBoardYear() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory/leaderboard/year'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    print(userJson.toString());
    return userJson;
  }

  @override
  Future<dynamic> leadBoardMonth() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory/leaderboard/month'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    print(userJson.toString());
    return userJson;
  }

  @override
  Future<dynamic> leadBoardDay() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory/leaderboard/days'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    print(userJson.toString());
    return userJson;
  }

  @override
  Future shortTextQuestion(int id) async {
    final response = await http.get(
      Uri.parse(companyLogin + '/api/quizapp/quizappexam/shorttextsubject/$id'),
      headers: {'Accept': 'application/json', 'Cookie': loginCookie},
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future getFinishExam() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/exam'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
      body: '',
    );
    var userJson = jsonDecode(response.body);
    return userJson["completed_exam"];
  }

  @override
  Future addAvatar(int id, int avatar) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercheckandadd/avatar/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
      body: jsonEncode({
        "avatar": avatar,
      }),
    );
    var userJson = jsonDecode(response.body);

    return userJson;
  }

  @override
  Future shortTextSubject() async {
    final response = await http.get(
      Uri.parse(companyLogin + '/api/quizapp/quizappexam/shorttextsubject'),
      headers: {'Accept': 'application/json', 'Cookie': loginCookie},
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future<dynamic> getExamQuestion(int id) async {
    final response = await http.post(
      Uri.parse(companyLogin + '/api/quizapp/get_exam_data/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    if (userJson.toString() == "no_exam_questions") {
      return [];
    } else {
      return userJson;
    }
  }

  @override
  Future getNowExam() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/exam'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    if (userJson.toString() == "empty_data") {
      return [];
    } else {
      return userJson["active_exams"];
    }
  }

  @override
  Future addUserQuizApp(int id) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercheckandadd'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
      body: jsonEncode({'user_id': id, 'coins': myCoin, 'points': myPoint}),
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future getDailyTests() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/homework'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future getDeveloperAllData() {
    // TODO: implement getDeveloperAllData
    throw UnimplementedError();
  }

  @override
  Future getReferenceId(String id) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory/referce_id/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future getTable(int id) {
    // TODO: implement getTable
    throw UnimplementedError();
  }

  @override
  Future shortTextSubjectQuestion(int id) {
    // TODO: implement shortTextSubjectQuestion
    throw UnimplementedError();
  }

  @override
  Future userExamTableAdd(
      String name,
      String examName,
      int examId,
      int id,
      int questions,
      int userNo,
      int trueQuestions,
      int falseQuestions,
      int emptyQuestions,
      String seconds) async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/quizappexam'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
      body: jsonEncode({
        'user_id': id,
        'exam_id': examId,
        'exam_name': examName,
        'question_count': questions,
        'true_questions': trueQuestions,
        'false_questions': falseQuestions,
        'empty_questions': emptyQuestions,
        'user_name': name,
        'seconds': seconds,
        'user_no': userNo,
      }),
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }

  @override
  Future userFinishExam() async {
    var userJson;

    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/quizappexam/user'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    userJson = jsonDecode(response.body);

    return userJson;
  }

  @override
  Future userCoinHistory() async {
    final response = await http.post(
      Uri.parse('$companyLogin/api/quizapp/usercoinhistory'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': loginCookie
      },
    );
    var userJson = jsonDecode(response.body);
    return userJson;
  }
}
*/
}