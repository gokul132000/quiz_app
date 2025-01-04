import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/base_controller.dart';
import 'package:quiz_app/screens/views/home/home_navigator.dart';
import 'package:quiz_app/screens/views/home/pages/performance_page.dart';
import 'package:quiz_app/screens/views/home/pages/quiz_page.dart';
import 'package:quiz_app/widgets/bottom_sheet.dart';


class HomeController extends BaseController implements HomeNavigator {
  final RxList<dynamic> questions = [].obs;
  final RxInt currentQuestionIndex = 0.obs;
  RxBool isResumeQuiz = false.obs;
  final RxMap<String, String> userAnswers = <String, String>{}.obs;
  final RxBool quizCompleted = false.obs;

  int correctAnswers = 0;
  int totalQuestions = 0;

  RxList<Map<String, dynamic>> completedQuizzes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadQuizData();
      loadProgress();  // Load quiz progress
      loadCompletedQuizzes();
    });
  }

  Future<void> loadQuizData() async {
    String data = await DefaultAssetBundle.of(Get.context!).loadString("assets/json/quiz.json");
    questions.value = json.decode(data);
    totalQuestions = questions.length;
  }

  void saveAnswer(String answer) {
    userAnswers[currentQuestionIndex.toString()] = answer;
    if (answer.trim().toLowerCase() == questions[currentQuestionIndex.value]['answer'].toString().trim().toLowerCase()) {
      correctAnswers++;
    }
    saveProgress();
  }

  void nextQuestion(String option) async {
    saveAnswer(option);
    if (currentQuestionIndex.value < totalQuestions - 1) {
      currentQuestionIndex.value++;
      saveProgress();
    } else {
      currentQuestionIndex.value++;
      quizCompleted.value = true;
      saveProgress();
      saveCompletedQuiz();
      navigateScreen(HomeNavigateScreens.home);
    }
  }

  void saveProgress() {
    storageService.saveData('currentQuestionIndex', currentQuestionIndex.value);
    storageService.saveData('userAnswers', userAnswers);
  }

  void loadProgress() {
    currentQuestionIndex.value = storageService.loadData('currentQuestionIndex', 0);
    var storedAnswers = storageService.loadData('userAnswers', <String, String>{});
    if (storedAnswers is Map<String, dynamic>) {
      userAnswers.assignAll(Map<String, String>.from(storedAnswers));
    } else {
      userAnswers.assignAll(storedAnswers);
    }
  }

  void saveCompletedQuiz() {
    completedQuizzes.add({
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'userAnswers': Map<String, String>.from(userAnswers),
    });
    storageService.saveData('completedQuizzes', completedQuizzes);
  }

  void loadCompletedQuizzes() {
    var storedQuizzes = storageService.loadData('completedQuizzes', <dynamic>[]);
    if (storedQuizzes is List) {
      completedQuizzes.assignAll(
        storedQuizzes.map((quiz) {
          if (quiz is Map<String, dynamic>) {
            quiz['userAnswers'] = Map<String, String>.from(quiz['userAnswers'] ?? {});
            return quiz;
          } else {
            return <String, dynamic>{};
          }
        }).toList(),
      );
    }
  }

  void updateResumeQuizState() {
    isResumeQuiz.value = currentQuestionIndex.value < totalQuestions && currentQuestionIndex.value != 0;
  }
  void startNewQuiz() {
    correctAnswers = 0;
    loadQuizData();
    currentQuestionIndex.value = 0;
    quizCompleted.value = false;
    userAnswers.clear();
  }


  @override
  navigateScreen(HomeNavigateScreens screen, [String param = ""]) {
    switch (screen) {
      case HomeNavigateScreens.home:
       Get.back();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ShowBottomSheet.showPerformanceBottomSheet(Get.context!);
        });
        break;
      case HomeNavigateScreens.performance:
        Get.to(() => PerformancePage());
        break;
      case HomeNavigateScreens.quiz:
        if (!isResumeQuiz.value) {
          startNewQuiz();
        }
        Get.to(() => QuizPage());
        break;
    }
  }
}

