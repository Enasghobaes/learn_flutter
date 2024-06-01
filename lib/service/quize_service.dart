import 'package:dio/dio.dart';
import 'package:quize2_api/model/model_quize.dart';

abstract class QuizService {
  Dio dio = Dio();
  late Response response;
  String baseurl = "https://66359296415f4e1a5e24d970.mockapi.io/quize_api";
  Future<bool> createNewQuiz(QuizModel quiz);

  Future<List<QuizModel>> getAllQuiz();
}

class QuizServiceImp extends QuizService {
  @override
  Future<bool> createNewQuiz(QuizModel quiz) async {
    try {
      response = await dio.post(baseurl, data: quiz.toMap());

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<List<QuizModel>> getAllQuiz() {
    throw UnimplementedError();
  }
}

// class QuizServiceget extends QuizService{
//   @override
//   Future<bool> createNewQuiz(QuizModel quiz)async {
//     try {
//       response = await dio.get(baseurl, data: quiz.toMap());
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } on DioException catch (e) {
//       print(e.message);
//       return false;
//     }
//   }

//   @override
//   Future<List<QuizModel>> getAllQuiz() {
//     // TODO: implement getAllQuiz
//     throw UnimplementedError();
//   }
// }
List<QuizModel> questio = [];
Future<List<QuizModel>> getquestionData() async {
  Dio req = Dio();

  try {
    Response response =
        await req.get("https://66359296415f4e1a5e24d970.mockapi.io/quize_api");
    for (var i = 0; i < response.data!.length; i++) {
      QuizModel question_st = QuizModel.fromMap(response.data![i]);

      questio.add(question_st);
      print(question_st);
    }
    return questio;
  } catch (e) {
    print(e);
    return questio;
  }
}
