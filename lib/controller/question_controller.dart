import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:http/http.dart' as http;

import '../models/quin_question.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TextEditingController nameController = TextEditingController();

  // Animated our progress bar
  late AnimationController _animationController;
  late Animation _animation;

  // we can access our animation outside
  Animation get animation => _animation;

  PageController _pageController = PageController();

  PageController get pagController => _pageController;

  final List<Question> _question = sample_data
      .map((e) => Question(
          id: e['id'],
          question: e['question'],
          options: e['options'],
          answer: e['answer_index']))
      .toList();


  List<Question> get questions => _question;

  bool _isAnswerd = false;

  bool get isAnswered => _isAnswerd;

  late int _correctAns;

  int get correctAns => _correctAns;

  late int _selectedAns;

  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;

  int get numOfCorrectAns => _numOfCorrectAns;

  bool _isClicked = true;

  bool get isClicked => _isClicked;

  @override
  void onInit() {
    getQuizQuestions();
    // animation duration is 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    //start animation
    // once 60s is completed go to the next question
    _animationController.forward().whenComplete((nextQuestion));

    _pageController = PageController();

    super.onInit();
  }

  // called just before the controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
    //nameController.dispose();
    //_numOfCorrectAns =0;
  }

  void checkAns(Question question, int selectedIndex) {
    _isClicked = false;
    _isAnswerd = true;
    _correctAns = question.answer!;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    }
    //stop the counter
    _animationController.stop();
    update();

    //user select an ans after 3s it will go to next question
    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    _isClicked = true;
    if (_questionNumber.value != _question.length) {
      _isAnswerd = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      //Reset the counter
      _animationController.reset();

      //start counter again
      // once timer is finish go to the next question
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void setNumOfCorrectAns() {
    _questionNumber.value = 1;
    _isAnswerd = false;
    _numOfCorrectAns = 0;
    //Reset the counter
    _animationController.reset();

    //start counter again
    // once timer is finish go to the next question
    _animationController.forward().whenComplete(nextQuestion);
  }

  var quizList = <QnizQuestion>[].obs;

  Future<List<QnizQuestion>?> getQuizQuestions() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/infos'));
    if (response.statusCode == 200) {

      var json = response.body;
      quizList.value = qnizQuestionFromJson(json);
      // QnizQuestion _quizQuestion =
      //     QnizQuestion.fromJson(jsonDecode(response.body));
      // quizList.add(QnizQuestion(
      //   id: _quizQuestion.id,
      //   question: _quizQuestion.question,
      //   answerIndex: _quizQuestion.answerIndex,
      //   options: _quizQuestion.options,
      // ));
       //print('quizList');
       //print(quizList);
    } else {
      Get.snackbar('Error Loading Data',
          'Server responded : ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }
}
