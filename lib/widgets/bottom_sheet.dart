import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/views/home/home_controller.dart';
import 'package:quiz_app/widgets/primary_text.dart';

import '../resource/app_colors.dart';
import '../resource/app_dimension.dart';
import '../resource/app_font.dart';

class ShowBottomSheet{
  static void showPerformanceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return GetBuilder<HomeController>(
          builder: (quizController) {
            final correctAnswers = quizController.correctAnswers;
            final totalQuestions = quizController.totalQuestions;
            final percentage = ((correctAnswers / totalQuestions) * 100).toStringAsFixed(1);
            return ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.darkBlue, AppColors.primaryColor], // Dark Blue to Primary Blue
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Column(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      Center(
                        child: PrimaryText(
                          text: 'Quiz Completed!',
                          color: AppColors.whiteTextColor,
                          size: AppDimen.textSize28,
                          weight: AppFont.bold,
                        ),
                      ),
                      Divider(color: Colors.white54),
                      PrimaryText(
                        text: 'Performance:',
                        color: AppColors.whiteTextColor,
                        size: AppDimen.textSize20,
                        weight: AppFont.bold,
                      ),
                      PrimaryText(
                        text: 'Total Questions: $totalQuestions',
                        color: AppColors.whiteTextColor,
                        size: AppDimen.textSize18,
                      ),
                      PrimaryText(
                        text: 'Correct Answers: $correctAnswers',
                        color: AppColors.whiteTextColor,
                        size: AppDimen.textSize18,
                      ),
                      PrimaryText(
                        text: 'Score: $percentage%',
                        color: AppColors.progressColor,
                        size: AppDimen.textSize18,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Close',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}