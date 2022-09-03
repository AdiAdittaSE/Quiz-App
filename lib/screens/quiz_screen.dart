import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_controller.dart';
import 'package:quiz_app/controller/text_controller.dart';

import '../utlities/constants.dart';
import '../widgets/question_cart.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    TextController textController = Get.put(TextController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(textController.nameController.text),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: _questionController.nextQuestion,
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/icons/bg.svg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //   child: Container(
                  //     height: 50,
                  //     width: double.infinity,
                  //     color: Colors.transparent,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           textController.nameController.text,
                  //           style: const TextStyle(
                  //               fontSize: 22, fontWeight: FontWeight.bold),
                  //         ),
                  //         InkWell(
                  //           onTap: _questionController.nextQuestion,
                  //           child: const Text(
                  //             'Skip',
                  //             style: TextStyle(fontWeight: FontWeight.w500),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //Progress bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFF3F4768),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GetBuilder<QuestionController>(
                        init: QuestionController(),
                        builder: (controller) {
                          //print(controller.animation.value);
                          return Stack(
                            children: [
                              //LayoutBuilder provide us the available space for the container
                              //constraints.maxWidth needed for our animation
                              LayoutBuilder(
                                builder: (context, constraints) => Container(
                                  width: constraints.maxWidth *
                                      controller.animation.value,
                                  decoration: BoxDecoration(
                                    gradient: kPrimaryGradient,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding - 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${(controller.animation.value * 60).round()} sec'),
                                      SvgPicture.asset(
                                          'assets/icons/clock.svg'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // End Progress bar
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Obx(() {
                      return Text.rich(
                        TextSpan(
                            text:
                                'Question ${_questionController.questionNumber.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: kSecondaryColor),
                            children: [
                              TextSpan(
                                text:
                                    '/${_questionController.questions.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: kSecondaryColor),
                              ),
                            ]),
                      );
                    }),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: _questionController.updateTheQnNum,
                      controller: _questionController.pagController,
                      itemCount: _questionController.questions.length,
                      itemBuilder: (context, index) => QuestionCart(
                          question: _questionController.questions[index]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
