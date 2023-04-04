import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.nickName,
    required this.active,
  });

  String nombre;
  String apellido;
  String username;
  String password;
  String nickName;
  bool active;

  User copyWith({
    String? nombre,
    String? apellido,
    String? username,
    String? password,
    String? nickName,
    bool? active,
  }) =>
      User(
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        username: username ?? this.username,
        password: password ?? this.password,
        nickName: nickName ?? this.nickName,
        active: active ?? this.active,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json["Nombre"],
        apellido: json["Apellido"],
        username: json["Username"],
        password: json["Password"],
        nickName: json["NickName"],
        active: json["Active"],
      );

  factory User.empty() => User(nombre: "", apellido: "", username: "", password: "", nickName: "", active: false);

  Map<String, dynamic> toJson() => {
        "Nombre": nombre,
        "Apellido": apellido,
        "Username": username,
        "Password": password,
        "NickName": nickName,
        "Active": active,
      };
}
