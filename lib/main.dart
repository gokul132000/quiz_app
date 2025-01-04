import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_app/resource/app_colors.dart';
import 'package:quiz_app/screens/bindings/home_binding.dart';
import 'package:quiz_app/screens/views/home/pages/home_page.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.materialColor,
        useMaterial3: true,
      ),
      initialBinding: HomeBinding(),
      home: HomePage(),
    );
  }
}
