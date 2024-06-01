import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quize2_api/core/config/get_it.dart';
import 'package:quize2_api/model/model_quize.dart';
import 'package:quize2_api/service/quize_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({
    super.key,
  });
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Center(child: Text("hello")),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Enter your name:',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  // controller: name,
                  // onChanged: (value) {
                  //   core.get<SharedPreferences>().setString('name', value);
                  // },
                  decoration: InputDecoration(
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateQuiz(),
              ));
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

// ignore: must_be_immutable
class CreateQuiz extends StatelessWidget {
  CreateQuiz({super.key});
  // Int counter = questio.length as Int;

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController indexOfCorrect = TextEditingController();
  // List<TextEditingController> answers = [
  //   TextEditingController(),
  //   TextEditingController(),
  //   TextEditingController(),
  //   TextEditingController()
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  controller: question,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  // controller: answers[0],
                  controller: answer,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  // controller: answers[1],
                  controller: answer1,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  // controller: answers[2],
                  controller: answer2,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  // controller: answers[3],
                  controller: answer3,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: TextField(
                  controller: indexOfCorrect,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
          onTap: () async {
            // if (counter == 3) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const get_question(),
            //       ));
            // } else {
            bool status = await QuizServiceImp().createNewQuiz(QuizModel(
                question: question.text,
                answers: [
                  answer.text,
                  answer1.text,
                  answer2.text,
                  answer3.text
                ],
                indexOfCorrect: num.parse(indexOfCorrect.text)));

            if (status) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Error"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
            }
            // }
            // ;
          },
          child: Icon(Icons.send)),
    );
  }
}

double countquestion = 0.0;
int countcorrect = 0;
int countwrong = 0;
double counterCorrectAnswer = 0.0;
double counterwrongAnswer = 0.0;
PageController pageController = PageController();

class get_question extends StatefulWidget {
  const get_question({super.key});

  @override
  State<get_question> createState() => _get_questionState();
}

class _get_questionState extends State<get_question> {
  @override
  void setState(VoidCallback fn) {
    countquestion++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: questio.length,
        itemBuilder: (context, ind) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                    // width: 400,
                    height: 200,
                    color: Color.fromARGB(200, 199, 117, 145),
                    child: Column(children: [
                      Center(child: Text(questio[ind].question)),
                    ])),
                Container(
                  height: 400,
                  // width: 200,
                  child: ListView.builder(
                    itemCount: questio[ind].answers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (index == questio[ind].indexOfCorrect) {
                            counterCorrectAnswer + 0.1;
                            countcorrect++;
                          } else {
                            counterwrongAnswer + 0.1;
                            countwrong++;
                          }
                          pageController.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.bounceInOut);
                        },
                        subtitle: Text(questio[ind].answers[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class score_page extends StatefulWidget {
  const score_page({super.key});

  @override
  State<score_page> createState() => _score_pageState();
}

class _score_pageState extends State<score_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("your score")),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 225, 143, 170)),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("enas"
                        // core.get<SharedPreferences>().getString('name') ??
                        //     "No name",
                        ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 9, 230, 61),
                        minHeight: 10,
                        // value: counterCorrectAnswer
                      ),
                      LinearProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 230, 9, 27),
                        minHeight: 10,
                        // value: counterwrongAnswer,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

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
