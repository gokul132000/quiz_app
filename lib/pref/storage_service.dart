import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage storage = GetStorage();

  dynamic loadData(String key, dynamic defaultValue) {
    if (storage.hasData(key)) {
      return storage.read(key);
    }
    return defaultValue;
  }

  void saveData(String key, dynamic value) {
    storage.write(key, value);
  }

  void clearData(String key) {
    storage.remove(key);
  }

  void clearAll() {
    storage.erase();
  }
}
