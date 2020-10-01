import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textStyle = TextStyle(color: Colors.white, fontSize: 25);
  List<String> questions = [
    'Have you ever wrote a letter?',
    'Have you ever smoked a cigarette?',
    'Have you ever been hit on by someone who was too old?',
    'Have you ever been on the radio or on television?',
    'Have you ever stayed awake for an entire night?',
    'Have you ever broken something, like a window, and ran away?',
    'Have you ever won a contest and received a prize?',
    'Have you ever met a famous person or a celebrity?',
  ];
  var yesCounter = 0, questionIndex = 0;

  void sayNo() {
    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Have You Ever'),
      ),
      body: Center(
        child: (questionIndex < 5)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    questions[questionIndex],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Yes',
                      style: textStyle,
                    ),
                    color: Color.fromRGBO(78, 212, 121, 1),
                    onPressed: () {
                      setState(() {
                        yesCounter++;
                        questionIndex++;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'No',
                      style: textStyle,
                    ),
                    color: Colors.red[900],
                    onPressed: sayNo,
                  ),
                ],
              )
            : Column(
                children: [
                  // (yesCounter < 3)
                  //     ? Image.asset('assets/images/winner.png')
                  //     : Image.asset('assets/images/loser.png'),

                  Image.asset(
                    'assets/images/${(yesCounter < 3 ? 'winner' : 'loser')}.png',
                  ),
                  RaisedButton(
                    child: Text('Play Again'),
                    onPressed: () {
                      setState(() {
                        questions.shuffle();
                        questionIndex = 0;
                        yesCounter = 0;
                      });
                    },
                  )
                ],
              ),
      ),
    );
  }
}
