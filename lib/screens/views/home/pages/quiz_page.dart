import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/resource/app_colors.dart';
import 'package:quiz_app/resource/app_dimension.dart';
import 'package:quiz_app/resource/app_font.dart';
import 'package:quiz_app/screens/views/home/home_controller.dart';
import 'package:quiz_app/widgets/primary_scaffold.dart';
import 'package:quiz_app/widgets/primary_text.dart';


class QuizPage extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBarTitle: 'Quiz',
      body: Obx(() {
        if (controller.questions.isEmpty || controller.currentQuestionIndex.value > controller.totalQuestions - 1) {
          return Center(child: CircularProgressIndicator());
        }else {
          var currentQuestion = controller.questions[controller.currentQuestionIndex.value];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: 0,
                    end: (controller.currentQuestionIndex.value + 1) /
                        controller.totalQuestions,
                  ),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(16),
                      value: value,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor),
                    );
                  },
                ),
                const SizedBox(height: 20),
                PrimaryText(
                  text: '${controller.currentQuestionIndex.value + 1}/${controller.totalQuestions}',
                  size: AppDimen.textSize18,
                  weight: AppFont.bold,
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  switchOutCurve: Curves.linear,
                  duration: Duration(milliseconds: 100),
                  child: PrimaryText(
                    key: ValueKey<int>(controller.currentQuestionIndex.value),
                    text: currentQuestion['question'],
                    size: AppDimen.textSize22,
                    weight: AppFont.semiBold,
                  ),
                ),
                const SizedBox(height: 20),
                for (var option in currentQuestion['options'])
                  GestureDetector(
                    onTap: () {
                      controller.nextQuestion(option);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 12.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: PrimaryText(
                              text: option,
                              color: AppColors.whiteTextColor,
                              weight: AppFont.medium,
                              size: AppDimen.textSize18,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: AppColors.whiteIconColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }
      }),
    );
  }
}

