import 'dart:convert';

import 'package:rm_app/model/member_models.dart';
import 'package:rm_app/service/init_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberService {
  static SharedPreferences _sharedPreferences;
  InitService initService = InitService();
  static void _init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();
  MemberService() {
    _init();
  }
  Future<bool> save(MemberModel member) {
    member.id = initService.generateId();
    String members = _sharedPreferences.getString('members');
    MembersModel membersModel = MembersModel.fromJson(jsonDecode(members));
    membersModel.memberModel.add(member);
    return _sharedPreferences.setString(
        'members', '${jsonEncode(membersModel)}');
  }

  Future<bool> saveAll(List<MemberModel> members) {
    List<MemberModel> oldMembers = findAll();
    oldMembers.addAll(members);
    MembersModel membersModel = new MembersModel(memberModel: oldMembers);

    return _sharedPreferences.setString(
        'members', '${jsonEncode(membersModel)}');
  }

  MemberModel findById(int id) {
    String members = _sharedPreferences.getString('members');
    MembersModel membersModel = MembersModel.fromJson(jsonDecode(members));
    return membersModel.memberModel.where((element) => element.id == id).first;
  }

  List<MemberModel> findAll() {
    String members = _sharedPreferences.getString('members');
    MembersModel membersModel = MembersModel.fromJson(jsonDecode(members));
    return membersModel.memberModel;
  }

  Future<bool> deleteById(int id) {
    List<MemberModel> oldMembers = findAll();
    oldMembers.removeWhere((element) => element.id == id);
    MembersModel membersModel = MembersModel(memberModel: oldMembers);
    return _sharedPreferences.setString(
        'members', '${jsonEncode(membersModel)}');
  }
}
