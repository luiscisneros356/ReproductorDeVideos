import 'package:flutter/material.dart';
import 'package:verifarma/domain/user_loggin_impl.dart';

import '../user_model.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._userLogginImp);

  final UserLogginImp _userLogginImp;

  List<User> _userAllowLoggin = [];
  List<User> get usersAllowLoggin => _userAllowLoggin;

  Future<List<User>> fetchUsers() async {
    _userAllowLoggin = await _userLogginImp.userLoggin();

    return _userAllowLoggin;
  }

  bool checkUserLoggin({required String username, required String password}) {
    final allow = usersAllowLoggin.indexWhere((user) => user.username == username && user.password == password);
    if (allow == -1) {
      return false;
    }
    return true;
  }
}
