import 'package:flutter/material.dart';
import 'package:verifarma/data/local_storage.dart';

import '../impl/user_loggin_impl.dart';
import '../models/models.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._userLogginImp);

  final UserLogginImp _userLogginImp;

  List<User> _userAllowLoggin = [];
  List<User> get usersAllowLoggin => _userAllowLoggin;

  User _currentUser = User.empty();
  User get currentUser => _currentUser;

  String get usernameDB => Boxes.userDataBase.values.first.username;
  String get passwordDB => Boxes.userDataBase.values.first.password;

  bool get isAnonymousUser => _currentUser.nombre.isEmpty && _currentUser.apellido.isEmpty;
  String userNickname() {
    if (!isAnonymousUser) {
      return "${_currentUser.nombre[0]}${_currentUser.apellido[0]}";
    }
    return "";
  }

  Future<void> setCurrentUser({required String username, required String password}) async {
    _currentUser = usersAllowLoggin.firstWhere((user) => user.username == username && user.password == password);
    await Boxes.currentUser(_currentUser);
    notifyListeners();
  }

  Future<void> deletedUser() async {
    await Boxes.deletedUser();
  }

  void setAnonymousUser() {
    _currentUser = User.empty();
    notifyListeners();
  }

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

  String checkUserError({required String username, required String password}) {
    final userameError = usersAllowLoggin.indexWhere((user) => user.username == username);
    final passwordError = usersAllowLoggin.indexWhere((user) => user.password == password);

    if (userameError == -1) {
      return "Usuario incorrecto";
    } else if (passwordError == -1) {
      return "Contraseña incorreta";
    }
    return "No existe el usuario";
  }
}
