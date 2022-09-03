import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/text_controller.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/utlities/constants.dart';

import '../controller/question_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  QuestionController _questionController = Get.put(QuestionController());

  bool isQuizStart = false;

  void startQuiz(){
    _questionController.setNumOfCorrectAns();
    Get.to(const QuizScreen());
  }

  @override
  Widget build(BuildContext context) {
    //QuestionController controller = Get.put(QuestionController());
    TextController controller = Get.put(TextController())
;    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/icons/bg.svg',
            fit: BoxFit.fill,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2,),
                Text(
                  'Let\'s Play Quiz',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Text(
                  'Enter your information below',
                  // style: Theme.of(context).textTheme.headline4!.copyWith(
                  //   color: Colors.white,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
                const Spacer(),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    //Get.to(const QuizScreen());
                    startQuiz();
                  },
                  child: Container(
                    alignment: Alignment.center ,
                    width: double.infinity,
                    padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: const BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text('Lets Start Quiz', style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),),
                  ),
                ),
                const Spacer(flex: 2,),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
