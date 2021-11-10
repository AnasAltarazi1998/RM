import 'package:rm_app/model/member_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitService {
  static SharedPreferences _sharedPreferences;
  static void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    !_sharedPreferences.containsKey('UUID')
        ? _sharedPreferences.setInt('UUID', 0)
        : _sharedPreferences.getInt('UUID');
  }

  InitService() {
    _init();
  }
  int generateId() {
    int id = _sharedPreferences.getInt('UUID') + 1;
    _sharedPreferences.setInt('UUID', id);
    return id;
  }
}
