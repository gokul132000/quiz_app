import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/resource/app_colors.dart';
import 'package:quiz_app/resource/app_dimension.dart';
import 'package:quiz_app/resource/app_font.dart';
import 'package:quiz_app/screens/views/home/home_controller.dart';
import 'package:quiz_app/widgets/primary_scaffold.dart';
import 'package:quiz_app/widgets/primary_text.dart';



class PerformancePage extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBarTitle: "Quiz Performance",
      body: Obx(() {
        if (controller.completedQuizzes.isEmpty) {
          return Center(
            child: Text(
              'No completed quizzes yet.',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.completedQuizzes.length,
          itemBuilder: (context, index) {
            var quiz = controller.completedQuizzes[index];
            final correctAnswers = quiz['correctAnswers'];
            final totalQuestions = quiz['totalQuestions'];
            final percentage = (correctAnswers / totalQuestions) * 100;

            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.darkBlue, AppColors.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: percentage / 100),
                      duration: Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: 8.0,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.progressColor),
                                backgroundColor: Colors.white30,
                              ),
                            ),
                            PrimaryText(
                              text: '${(value * 100).toStringAsFixed(1)}%',
                              size: AppDimen.textSize14,
                              color: AppColors.whiteTextColor,
                              weight: AppFont.bold,
                            ),
                          ],
                        );
                      },
                    ),
                   const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            text: 'Quiz ${index + 1}',
                            size: AppDimen.textSize20,
                            color: AppColors.whiteTextColor,
                            weight: AppFont.bold,
                          ),
                          SizedBox(height: 8),
                          PrimaryText(
                            text: 'Correct Answers: $correctAnswers/$totalQuestions',
                            size: AppDimen.textSize16,
                            color: AppColors.whiteTextColor.withAlpha(200),
                            weight: AppFont.medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}



