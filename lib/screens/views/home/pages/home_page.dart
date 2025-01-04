import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/resource/app_colors.dart';
import 'package:quiz_app/resource/app_dimension.dart';
import 'package:quiz_app/screens/views/home/home_controller.dart';
import 'package:quiz_app/screens/views/home/home_navigator.dart';
import 'package:quiz_app/widgets/primary_scaffold.dart';
import 'package:quiz_app/widgets/primary_text.dart';


class HomePage extends GetView<HomeController>{

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBarTitle: 'Hi! Welcome to the Quiz App.',
      appBarSubTitle: 'Let\'s get started!',
      isLeadingIconDisable: true,
      body: Obx(() {
        controller.updateResumeQuizState();
        return Center(
          child: Column(
            spacing: 40,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5.0,),
              _showCardView(
                  onTap: (){
                    controller.navigateScreen(HomeNavigateScreens.quiz);
                  },
                  iconData: controller.isResumeQuiz.value ? Icons.pause_circle_filled_sharp :Icons.play_arrow,
                  text: controller.isResumeQuiz.value ? "Resume Quiz" : "Start New Quiz",
              ),
              _showCardView(
                  onTap: (){
                    controller.navigateScreen(HomeNavigateScreens.performance);
                  },
                  iconData: Icons.assessment,
                  text: "Quiz Performance"
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _showCardView({required GestureTapCallback? onTap,required IconData iconData,required String text}){
    return    Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.whiteBgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Icon(iconData, size: 80, color: AppColors.primaryColor),
                  SizedBox(height: 20),
                  PrimaryText(
                    text: text,
                    size: AppDimen.textSize24,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Positioned(
                bottom: -88,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.darkBlue, AppColors.primaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.whiteBgColor.withAlpha(200),
                        blurRadius: 12,
                        offset: Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.whiteBgColor,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.whiteIconColor, // Icon color
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
