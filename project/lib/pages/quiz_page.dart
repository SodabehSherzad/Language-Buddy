import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/apartment.dart';
import '../data/bank.dart';
import '../data/bathroom_appliances.dart';
import '../data/dentist_visit.dart';
import '../data/doctor_specialists.dart';
import '../data/doctor_visit.dart';
import '../data/emergency.dart';
import '../data/immigration.dart';
import '../data/kitchen_appliances.dart';
import '../data/pharmacy.dart';
import '../data/psychology.dart';
import '../data/shopping.dart';
import '../data/transportation.dart';
import '../data/travel.dart';
import '../data/airport.dart';
import '../data/animals.dart';
import '../data/bedroom_appiances.dart';
import '../data/computer_and_it.dart';
import '../data/cosmetics.dart';
import '../data/culture.dart';
import '../data/dating.dart';
import '../data/diseases.dart';
import '../data/education.dart';
import '../data/environment.dart';
import '../data/family.dart';
import '../data/feelings.dart';
import '../data/food.dart';
import '../data/fruits.dart';
import '../data/hobbies.dart';
import '../data/hotel.dart';
import '../data/human_body.dart';
import '../data/insurance.dart';
import '../data/job_interview.dart';
import '../data/legal_matters.dart';
import '../data/living_room_appliances.dart';
import '../data/public_services.dart';
import '../data/social_interaction.dart';
import '../data/spices.dart';
import '../data/stationary.dart';
import '../data/topic_enum.dart';
import '../data/useful_adjectives.dart';
import '../data/useful_nouns.dart';
import '../data/useful_verbs.dart';
import '../data/useful_words.dart';
import '../data/utilities.dart';
import '../data/vegetables.dart';
import '../data/weather.dart';
import '../methods/get_data.dart';

class QuizPage extends StatefulWidget {
  static const RoutName = "/quiz";
  final int id;
  final String language;
  final String name;

  QuizPage({
    required this.id,
    required this.language,
    required this.name,
  });
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Initialize your variables and lists
  List<Map<String, dynamic>>? questions;
  List? topic;
  int currentQuestionIndex = 0;
  bool? answerCorrect;
  String? option1;
  String? option2;
  Color option1Color = Colors.blue;
  Color option2Color = Colors.blue;
  int incorrectAnswers = 0;
  int correctAnswers = 0;
  int? answerSelected;
  bool showResetButton = false;
  bool showFeedback = false;
  String feedbackText = '';

  // Define a map to store the colors of options
  Map<int, Color> optionColors = {
    0: Colors.blue,
    1: Colors.blue,
  };

  @override
  void initState() {
    super.initState();
    topic = mapIdToTopic(widget.id);
    final _data = VocabularyMethods(topic?.cast<Map<String, dynamic>>());
    final vocabularyData = _data.getVocabularyData();

    // Adapt the vocabularyData to a List<Map<String, dynamic>> format
    questions = vocabularyData.map((vocabularyModel) {
      return {
        'name_de': vocabularyModel.name_de,
        'name_en': vocabularyModel.name_en,
        'name_fa': vocabularyModel.name_fa,
        'correct_answer_index': vocabularyModel.correct_answer_index,
      };
    }).toList();

    loadOptions();
  }

  void loadOptions() {
    final currentQuestion = questions![currentQuestionIndex];
    final random = Random();
    int randomIndex;

    if (widget.language == 'en') {
      // If English is selected, load both options in English
      if (currentQuestion['correct_answer_index'] == 0) {
        // When correct_answer_index is 0, set option1 to the correct English translation
        option1 = currentQuestion['name_en'];
        do {
          randomIndex = random.nextInt(questions!.length - 1);
        } while (randomIndex == currentQuestionIndex ||
            questions![randomIndex]['correct_answer_index'] == 0);
        option2 = questions![randomIndex][
        'name_en']; // Set option2 to a random incorrect English translation
      } else {
        // When correct_answer_index is 1, set option2 to the correct English translation
        option2 = currentQuestion['name_en'];
        do {
          randomIndex = random.nextInt(questions!.length - 1);
        } while (randomIndex == currentQuestionIndex ||
            questions![randomIndex]['correct_answer_index'] == 1);
        option1 = questions![randomIndex][
        'name_en']; // Set option1 to a random incorrect English translation
      }
    } else if (widget.language == 'fa') {
      // If Persian is selected, load both options in Persian
      if (currentQuestion['correct_answer_index'] == 0) {
        // When correct_answer_index is 0, set option1 to the correct Persian translation
        option1 = currentQuestion['name_fa'];
        do {
          randomIndex = random.nextInt(questions!.length - 1);
        } while (randomIndex == currentQuestionIndex ||
            questions![randomIndex]['correct_answer_index'] == 0);
        option2 = questions![randomIndex][
        'name_fa']; // Set option2 to a random incorrect Persian translation
      } else {
        // When correct_answer_index is 1, set option2 to the correct Persian translation
        option2 = currentQuestion['name_fa'];
        do {
          randomIndex = random.nextInt(questions!.length - 1);
        } while (randomIndex == currentQuestionIndex ||
            questions![randomIndex]['correct_answer_index'] == 1);
        option1 = questions![randomIndex][
        'name_fa']; // Set option1 to a random incorrect Persian translation
      }
    }

    // Reset button colors to default (white)
    option1Color = Colors.blue;
    option2Color = Colors.blue;

    // Reset button colors to default (blue) for both options
    optionColors[0] = Colors.blue;
    optionColors[1] = Colors.blue;

    setState(() {});
  }

  void checkAnswer(int selectedOptionIndex) {
    setState(() {
      final currentQuestion = questions![currentQuestionIndex];
      final correctAnswerIndex = currentQuestion['correct_answer_index'];
      answerCorrect = selectedOptionIndex == correctAnswerIndex;

      // Update the color of selected option
      optionColors[selectedOptionIndex] =
      answerCorrect! ? Colors.green : Colors.red;

      // Update the score based on whether the answer is correct
      updateScore(answerCorrect!);
      // Set feedback text based on the user's selection
      feedbackText = answerCorrect! ? 'Correct!' : 'Incorrect!';
    });
  }

  List mapIdToTopic(int id) {
    switch (id) {
      case 1:
        return doctor_visit;
      case 2:
        return dentist_visit;
      case 3:
        return pharmacy;
      case 4:
        return diseases;
      case 5:
        return doctor_specialists;
      case 6:
        return psychology;
      case 7:
        return emergency;
      case 8:
        return insurance;
      case 9:
        return bank;
      case 10:
        return immigration;
      case 11:
        return transportation;
      case 12:
        return travel;
      case 13:
        return shopping;
      case 14:
        return apartment;
      case 15:
        return kitchen_appliances;
      case 16:
        return bathroom_appliances;
      case 17:
        return bedroom_appliances;
      case 18:
        return living_room_appliances;
      case 19:
        return computer_and_it;
      case 20:
        return stationary;
      case 21:
        return education;
      case 22:
        return job_interview;
      case 23:
        return social_interaction;
      case 24:
        return culture;
      case 25:
        return legal_matters;
      case 26:
        return utilities;
      case 27:
        return public_services;
      case 28:
        return weather;
      case 29:
        return hobbies;
      case 30:
        return environment;
      case 31:
        return dating;
      case 32:
        return cosmetics;
      case 33:
        return food;
      case 34:
        return animals;
      case 35:
        return vegetables;
      case 36:
        return fruits;
      case 37:
        return spices;
      case 38:
        return feelings;
      case 39:
        return human_body;
      case 40:
        return family;
      case 41:
        return airport;
      case 42:
        return hotel;
      case 43:
        return useful_words;
      case 44:
        return useful_verbs;
      case 45:
        return useful_adjectives;
      case 46:
        return useful_nouns;
      default:
        throw Exception("Invalid topic ID");
    }
  }

  void updateScore(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        correctAnswers++;
      });
    } else {
      setState(() {
        incorrectAnswers++;
      });
    }
  }

  void nextQuestion() {
    setState(() {
      currentQuestionIndex++;
      answerSelected = null;
      answerCorrect = null;
      loadOptions();
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      answerSelected = null;
      answerCorrect = null;
      correctAnswers = 0;
      incorrectAnswers = 0;
      loadOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions![currentQuestionIndex];
    final questionText = currentQuestion['name_de'];
    final totalQuestions = questions!.length - 1;
    final isQuizEnd = currentQuestionIndex >= questions!.length - 1;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  questionText,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                _buildAnswerButton(0, option1!),
                _buildAnswerButton(1, option2!),
                SizedBox(height: 20),
                _buildFeedbackText(isQuizEnd), // Call _buildFeedbackText here
                SizedBox(height: 20),
                _buildNavigationButtons(isQuizEnd),
              ],
            ),
          ),
        ),),
    );
  }

  Widget _buildNavigationButtons(bool isQuizEnd) {
    bool isNextButtonEnabled = answerCorrect != null && !showFeedback;
    bool showResetAndFeedbackButtons = isQuizEnd && showFeedback;

    return Column(
      children: <Widget>[
        if (!showResetAndFeedbackButtons) // Only show "Next Question" button
          ElevatedButton(
            onPressed: isNextButtonEnabled
                ? () {
              setState(() {
                if (!isQuizEnd) {
                  currentQuestionIndex++;
                  answerSelected = null;
                  answerCorrect = null;
                  loadOptions();
                } else {
                  // Show Reset Quiz Button and Total Feedback
                  setState(() {
                    showFeedback = true;
                    showResetButton = true;
                  });
                }
              });
            }
                : null,
            child: Text(isQuizEnd ? 'Show Total Feedback' : 'Next Question'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal:
                  50), // Adjust these values to increase button size
            ),
          ),
        SizedBox(height: 20), // Add vertical spacing between buttons
        if (showResetAndFeedbackButtons) // Show "Reset Quiz" and "Show Feedback" buttons
          Column(
            children: <Widget>[
              Text(
                feedbackText,
                style: TextStyle(
                  fontSize: 24,
                  color: answerCorrect! ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Reset the quiz and hide Reset Quiz Button
                    resetQuiz();
                    showResetButton = false;
                    showFeedback = false;
                  });
                },
                child: Text('Reset Quiz'),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    Color? tileColor = optionColors[index]; // Get the color from the map

    return GestureDetector(
      onTap: answerCorrect == null ? () => checkAnswer(index) : null,
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

  Widget _buildFeedbackText(bool isQuizEnd) {
    if (isQuizEnd && showFeedback) {
      return Column(
        children: [
          Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Correct Answers: $correctAnswers',
              style: TextStyle(fontSize: 20)),
          Text('Incorrect Answers: $incorrectAnswers',
              style: TextStyle(fontSize: 20)),
        ],
      );
    } else {
      return answerCorrect == null
          ? SizedBox.shrink()
          : Column(
        children: [
          Text(
            feedbackText,
            style: TextStyle(
              fontSize: 24,
              color: answerCorrect! ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}