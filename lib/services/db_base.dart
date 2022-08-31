abstract class DBBase {
  Future<dynamic> allCourses(); //Bütün Dersler Gelişim modu

  Future<dynamic> getCourseSubject(int id); //Derslerin konuları

  Future<dynamic> getCourseSubjectQuestion(int id); //Konularının tüm sorunları

/*  Future<dynamic> shortTextSubject(); //Kısa cevaplı soruların konuları

  Future<dynamic> shortTextSubjectQuestion(int id); //Kısa cevaplı sorular

  Future<dynamic> addUserQuizApp(int id); //QuizApp tablosuna kullanıcı ekleme

  Future<dynamic> addAvatar(int id, int avatar); //Kullanıcıya avatar ekleme

  Future<dynamic> getTable(int id); //QuizApp tablosuna verilerin alınması

  Future<dynamic> getReferenceId(String id); //Referans kodu ile kayıt olma

  Future<dynamic> getNowExam(); //Kullanıcıya ait yapabileceği sınavlar

  Future<dynamic> getExamQuestion(
      int id); //Kullanıcıya ait yapabileceği sınavların soruları

  Future<dynamic> userExamTableAdd(
      String name,
      String examName,
      int examId,
      int id,
      int questions,
      int userNo,
      int trueQuestions,
      int falseQuestions,
      int emptyQuestions,
      String seconds); //QuizApp sınavlarının verilerini tabloya ekleme

  Future<dynamic>
  userFinishExam(); //Kullanıcının bitirmiş olduğu sınavlar ve verileri


  Future<dynamic> getDailyTests(); //Günlük test isimleri,

  Future<dynamic> getDailyTestsQuestion(int id); //Günlük test soruları,



  Future<dynamic> getDeveloperAllData(); //Geliştirme modunun bütün verileri

  Future<dynamic> userCoinHistoryAdd(
      int id,
      int coins,
      int points,
      int questions,
      int trueQuestions,
      int falseQuestions,
      int emptyQuestions,
      String seconds); //Kullanıcıya ait coin ve puan ekleme
  Future<dynamic> userCoinHistory();

  Future<dynamic> notification(); //Bildirimler

  Future<dynamic> readNotification(String id); //Bildirimlerin okunması

  Future<dynamic> questionOneVsOne(); //bire bir yarış soruları

  Future<dynamic> addFavoriteQuestion(int id); //soruları favoriye ekleme

  Future<dynamic> favoriteQuestionSubject(); //favori sorularının konuları

  Future<dynamic> favoriteQuestionLesson(); //favori soruların dersleri

  Future<dynamic> favoriteQuestion(); //Favori soruların getirilmesi

  Future<dynamic> questionBankSubject(); //soru bankası ekleme

  Future<dynamic> deleteFavoriteQuestion(int id); //favori soruları kaldırma

  Future<dynamic> attemptQuestion(String id); //deneme sorularının getirilmesi

  Future<dynamic> leadBoardYear(); //liderlik sıralaması yıllık

  Future<dynamic> leadBoardMonth(); //liderlik sıralaması aylık

  Future<dynamic> leadBoardDay(); //liderlik sıralaması günlük

  Future<dynamic> shortTextQuestion(int id); //Soru cevap sayfasının soruları

  Future<dynamic> getFinishExam(); //kulllanıcının yaptığı sınavlar*/

}