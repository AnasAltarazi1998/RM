import 'dart:convert';

import 'package:rm_app/model/status_models.dart';
import 'package:rm_app/service/init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusService {
  static SharedPreferences _sharedPreferences;
  InitService initService = InitService();
  static void _init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();
  StatusService() {
    _init();
  }
  Future<bool> save(StatusModel status) {
    status.id = initService.generateId();
    String statuses = _sharedPreferences.getString('statuses');
    StatusesModel statusesModel = StatusesModel.fromJson(jsonDecode(statuses));
    statusesModel.statusModel.add(status);
    return _sharedPreferences.setString(
        'statuses', '${jsonEncode(statusesModel)}');
  }

  List<StatusModel> findAll() {
    String statuses = _sharedPreferences.getString('statuses');
    StatusesModel statusesModel = StatusesModel.fromJson(jsonDecode(statuses));
    return statusesModel.statusModel;
  }

//TODO: EDIT METHODS TO FIT THIS CLASS...
  Future<bool> saveAll(List<StatusModel> statuses) {
    List<StatusModel> oldStatuses = findAll();
    oldStatuses.addAll(statuses);
    StatusesModel statusesModel = new StatusesModel(statusModel: oldStatuses);

    return _sharedPreferences.setString(
        'statuses', '${jsonEncode(statusesModel)}');
  }

  StatusModel findById(int id) {
    String statuses = _sharedPreferences.getString('statuses');
    StatusesModel statusesModel = StatusesModel.fromJson(jsonDecode(statuses));
    return statusesModel.statusModel.where((element) => element.id == id).first;
  }

  Future<bool> deleteById(int id) {
    List<StatusModel> oldStatuses = findAll();
    oldStatuses.removeWhere((element) => element.id == id);
    StatusesModel statusesModel = StatusesModel(statusModel: oldStatuses);
    return _sharedPreferences.setString(
        'statuses', '${jsonEncode(statusesModel)}');
  }
}
