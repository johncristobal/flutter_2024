import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_service.dart';

class KeyValueStorageServiceImpl extends KeyValueService {

  Future<SharedPreferences> getSharedprefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
   final prefs = await getSharedprefs();
    switch(T) {
      case int:
      return prefs.getInt(key) as T?;
      case String:
      return prefs.getString(key) as T?;
      default: throw UnimplementedError("Get not implemented");
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedprefs();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedprefs();
    switch(T) {
      case int:
      prefs.setInt(key, value as int);
      break;
      case String:
      prefs.setString(key, value as String);
      break;
      default: throw UnimplementedError("Set not implemented");
    }
  }
}