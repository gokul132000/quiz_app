import 'package:get/get.dart';

import '../pref/storage_service.dart';

class BaseController extends FullLifeCycleController with FullLifeCycleMixin {
  final StorageService storageService = StorageService();

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

}