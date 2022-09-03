import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question_controller.dart';

import '../models/Questions.dart';
import '../utlities/constants.dart';
import 'options.dart';

class QuestionCart extends StatelessWidget {
  const QuestionCart({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());

    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              question.question.toString(),
              //_controller.quizList[0].question.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: kBlackColor),
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            ...List.generate(
                question.options!.length,
                (index) => Options(
                      text: question.options![index],
                      index: index,
                      //press: () =>_controller.checkAns(question, index),
                      press: () =>_controller.isClicked == false ? null : _controller.checkAns(question, index),
                    ))
          ],
        ),
      ),
    );
  }
}
