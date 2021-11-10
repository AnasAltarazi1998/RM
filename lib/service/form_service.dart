import 'dart:convert';

import 'package:rm_app/model/form_models.dart';
import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/model/member_with_status_models.dart';
import 'package:rm_app/service/init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormService {
  static SharedPreferences _sharedPreferences;
  InitService initService = InitService();
  static void _init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();
  FormService() {
    _init();
  }

  Future<bool> save(FormModel formModel) {
    formModel.id = initService.generateId();
    String forms = _sharedPreferences.getString('forms');
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    formsModel.formModel.add(formModel);
    return _sharedPreferences.setString('forms', '${jsonEncode(formsModel)}');
  }

  Future<bool> addMember(MemberWithStatusModel memberModel, int formID) {
    String forms = _sharedPreferences.getString('forms');
    if (memberModel.id == null) memberModel.id = initService.generateId();
    if (memberModel.statusModel.id == null)
      memberModel.statusModel.id = initService.generateId();
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    FormModel formModel =
        formsModel.formModel.firstWhere((element) => element.id == formID);
    formModel.members.add(memberModel);
    formsModel.formModel = formsModel.formModel.map<FormModel>((e) {
      if (e.id == formID) e.members = formModel.members;
      return e;
    }).toList();
    return _sharedPreferences.setString('forms', '${jsonEncode(formsModel)}');
  }

  bool addMembers(List<MemberWithStatusModel> members, int formID) {
    for (var item in members) {
      addMember(item, formID);
    }
    return true;
  }

  FormModel findById(int id) {
    String forms = _sharedPreferences.getString('forms');
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    return formsModel.formModel.where((element) => element.id == id).first;
  }

  List<FormModel> findAll() {
    String forms = _sharedPreferences.getString('forms');
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    return formsModel.formModel;
  }

  Future<bool> deleteById(int id) {
    String forms = _sharedPreferences.getString('forms');
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    formsModel.formModel.removeWhere((element) => element.id == id);
    return _sharedPreferences.setString('forms', '${jsonEncode(formsModel)}');
  }

  Future<bool> deleteMemberFromForm(int memberId, int meetingId) {
    String forms = _sharedPreferences.getString('forms');
    FormsModel formsModel = FormsModel.fromJson(jsonDecode(forms));
    List<FormModel> newForms = formsModel.formModel.map((e) {
      if (e.id == meetingId)
        e.members.removeWhere((element) => element.id == memberId);
      return e;
    }).toList();
    formsModel.formModel = newForms;
    return _sharedPreferences.setString('forms', '${jsonEncode(formsModel)}');
  }
}
