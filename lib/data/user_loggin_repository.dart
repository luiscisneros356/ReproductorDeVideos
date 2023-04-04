import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:verifarma/domain/user_loggin_impl.dart';
import 'package:verifarma/domain/user_model.dart';

const userDataJson = "assets/user.json";

class UserLogginRepository extends UserLogginImp {
  @override
  Future<List<User>> userLoggin() async {
    List<User> listUser = [];

    await rootBundle.loadString(userDataJson).then((value) {
      final users = jsonDecode(value) as List;
      final userParse = users.map((user) => User.fromJson(user)).toList();
      listUser = userParse;
    });

    return listUser;
  }
}
