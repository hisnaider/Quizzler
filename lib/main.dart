import 'package:flutter/material.dart';
import "package:quickalert/quickalert.dart";
import 'quiz_brain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Quizzler(),
          ),
        ),
      ),
    );
  }
}

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  List<bool> scoreKepper = [];
  QuizBrain quizBrain = QuizBrain();
  void checkAnswer(bool userAnswer, context) {
    scoreKepper.add(quizBrain.getAnswer(userAnswer));
    if (quizBrain.nextQuestion() == false) {
      QuickAlert.show(
        barrierDismissible: false,
        context: context,
        type: QuickAlertType.success,
        title:
            "${((scoreKepper.where((element) => element == true).length / quizBrain.getQuestionLenght()) * 100).toStringAsFixed(1)}%",
        text:
            "Você acertou ${scoreKepper.where((element) => element == true).length} de ${quizBrain.getQuestionLenght()}",
        confirmBtnText: "Tentar novamente",
        onConfirmBtnTap: () => Navigator.pop(context),
      );
      quizBrain.restartQuiz();
      setState(() {
        scoreKepper = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Pergunta numero: ${scoreKepper.length + 1}"),
        Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestion(),
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true, context);
                });
              },
              child: const Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false, context);
                });
              },
              child: const Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: scoreKepper.length,
              itemBuilder: (BuildContext context, int index) {
                if (scoreKepper[index] == true) {
                  return const Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                } else {
                  return const Icon(
                    Icons.close,
                    color: Colors.red,
                  );
                }
              }),
        )
      ],
    );
  }
}
