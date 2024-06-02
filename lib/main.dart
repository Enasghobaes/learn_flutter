import 'package:flutter/material.dart';
import 'package:quize2_api/core/config/get_it.dart';
import 'package:quize2_api/model/model_quize.dart';
import 'package:quize2_api/service/quize_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const MyApp());
}

PageController pageController = PageController();
double countcorrectprogresslinear = 0.0;
double countwrongprogresslinear = 0.0;
int counterCorrectAnswer = 0;
int counterwrongAnswer = 0;
int count = 0;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Enter your name:',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextField(
                  // controller: name,
                  onChanged: (value) {
                    core.get<SharedPreferences>().setString('name', value);
                  },
                  decoration: const InputDecoration(
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
          if (core.get<SharedPreferences>().getString('name') == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Enter your name"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateQuiz(),
                ));
          }
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

int counter = 0;

// ignore: must_be_immutable
class CreateQuiz extends StatelessWidget {
  CreateQuiz({super.key});

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController indexOfCorrect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
      floatingActionButton: InkWell(
          onTap: () async {
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
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Success"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ));
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error"),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
            }
            counter++;
            if (counter == 1) {
              Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => const questionpage(),
                  ));
            }
          },
          child: const Icon(Icons.send)),
    );
  }
}

// ignore: camel_case_types
// class questionpage extends StatelessWidget {
//   const questionpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: PageView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       controller: pageController,
//       itemCount: questio.length,
//       itemBuilder: (context, ind) {
//         return Scaffold(
//           body: Column(
//             children: [
//               Container(
//                 // width: 400,
//                 height: 200,
//                 color: const Color.fromARGB(200, 199, 117, 145),
//                 child: Column(children: [
//                   Center(child: Text(questio[ind].question)),
//                   SizedBox(
//                     height: 400,
//                     // width: 200,
//                     child: ListView.builder(
//                       itemCount: questio[ind].answers.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () {
//                             if (index == questio[ind].indexOfCorrect) {
//                               countcorrectprogresslinear + 0.1;
//                               counterCorrectAnswer++;
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     dismissDirection:
//                                         DismissDirection.horizontal,
//                                     showCloseIcon: true,
//                                     behavior: SnackBarBehavior.floating,
//                                     backgroundColor: Colors.green,
//                                     content: Text("CorrectAnswer")),
//                               );
//                             } else {
//                               countwrongprogresslinear + 0.1;
//                               counterwrongAnswer++;
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   dismissDirection: DismissDirection.horizontal,
//                                   showCloseIcon: true,
//                                   behavior: SnackBarBehavior.floating,
//                                   backgroundColor: Colors.red,
//                                   content: Text("wrongAnswer"),
//                                 ),
//                               );
//                             }

//                             pageController.nextPage(
//                                 duration: const Duration(seconds: 1),
//                                 curve: Curves.bounceInOut);
//                             count++;

//                             if (count == 3) {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const score_page(),
//                                   ));
//                             }
//                           },
//                           subtitle: Text(questio[ind].answers[index]),
//                         );
//                       },
//                     ),
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         );
//       },
//     ));
//   }
// }

class questionpage extends StatefulWidget {
  const questionpage({super.key});

  @override
  State<questionpage> createState() => _questionpageState();
}

class _questionpageState extends State<questionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("solve for all question:"),
      ),
      body: Container(
        // color: Colors.brown,
        child: FutureBuilder(
          future: getquestionData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  width: 700,
                  height: 700,
                  // color: const Color.fromARGB(200, 199, 117, 145),
                  child: Column(children: [
                    SizedBox(
                      height: 400,
                      // width: 200,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              snapshot.data![index].question,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              if (index == questio[index].indexOfCorrect) {
                                countcorrectprogresslinear + 0.1;
                                counterCorrectAnswer++;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      dismissDirection:
                                          DismissDirection.horizontal,
                                      showCloseIcon: true,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                      content: Text("CorrectAnswer")),
                                );
                              } else {
                                countwrongprogresslinear + 0.1;
                                counterwrongAnswer++;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    showCloseIcon: true,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text("wrongAnswer"),
                                  ),
                                );
                              }

                              pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.bounceInOut);
                              count++;

                              if (count == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const score_page(),
                                    ));
                              }
                            },
                            subtitle: Text(questio[index].answers[index]),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class score_page extends StatelessWidget {
  const score_page({super.key});

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      core.get<SharedPreferences>().getString('name') ??
                          "No name",
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: const Color.fromARGB(255, 9, 230, 61),
                        minHeight: 10,
                        value: countcorrectprogresslinear,
                      ),
                      LinearProgressIndicator(
                        backgroundColor: const Color.fromARGB(255, 230, 9, 27),
                        minHeight: 10,
                        value: countwrongprogresslinear,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
