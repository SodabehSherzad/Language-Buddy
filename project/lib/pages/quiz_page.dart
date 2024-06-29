import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  String option1 = 'Option 1';
  String option2 = 'Option 2';
  Color option1Color = Colors.blue;
  Color option2Color = Colors.blue;
  bool showResetButton = false;
  bool showFeedback = false;
  String feedbackText = '';

  @override
  Widget build(BuildContext context) {
    final totalQuestions = 10; // Example total number of questions

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Question ${currentQuestionIndex + 1}/$totalQuestions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Question Text Here',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildAnswerButton(0, option1),
              _buildAnswerButton(1, option2),
              SizedBox(height: 20),
              _buildFeedbackText(),
              SizedBox(height: 20),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    bool isNextButtonEnabled = !showFeedback;
    bool showResetAndFeedbackButtons = showFeedback;

    return Column(
      children: <Widget>[
        if (!showResetAndFeedbackButtons)
          ElevatedButton(
            onPressed: isNextButtonEnabled ? () => nextQuestion() : null,
            child: Text('Next Question'),
          ),
        SizedBox(height: 20),
        if (showResetAndFeedbackButtons)
          Column(
            children: <Widget>[
              Text(
                feedbackText,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => resetQuiz(),
                child: Text('Reset Quiz'),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    Color tileColor = index == 0 ? option1Color : option2Color;

    return GestureDetector(
      onTap: () => checkAnswer(index),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFeedbackText() {
    return showFeedback
        ? Text(
      feedbackText,
      style: TextStyle(
        fontSize: 24,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    )
        : SizedBox.shrink();
  }

  void checkAnswer(int selectedOptionIndex) {
    setState(() {
      bool answerCorrect = selectedOptionIndex == 0; // Simulated correct answer logic

      if (answerCorrect) {
        feedbackText = 'Correct!';
      } else {
        feedbackText = 'Incorrect!';
      }

      showFeedback = true;
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      showFeedback = false;
      // Simulated new question and options
      option1 = 'Option 1 for Q${currentQuestionIndex + 1}';
      option2 = 'Option 2 for Q${currentQuestionIndex + 1}';
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      showFeedback = false;
      // Reset options
      option1 = 'Option 1';
      option2 = 'Option 2';
    });
  }
}
