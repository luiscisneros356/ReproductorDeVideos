import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject {
  User({
    required this.nombre,
    required this.apellido,
    required this.username,
    required this.password,
    required this.nickName,
    required this.active,
  });
  @HiveField(1)
  String nombre;
  @HiveField(2)
  String apellido;
  @HiveField(3)
  String username;
  @HiveField(4)
  String password;
  @HiveField(5)
  String nickName;
  @HiveField(6)
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
