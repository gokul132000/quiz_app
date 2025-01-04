import 'package:get/get.dart';
import 'package:quiz_app/screens/views/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=> HomeController(),fenix: true);
  }
}