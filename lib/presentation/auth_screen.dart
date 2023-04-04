import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:verifarma/domain/providers/user_provider.dart';
import 'package:verifarma/main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userLoggin = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey.shade300,
                    ),
                    child: Column(
                      children: [
                        CustomTexField(
                          isInLoggin: true,
                          hint: "Username",
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              username = value;

                              return null;
                            }
                            return "Campo vacio";
                          },
                        ),
                        CustomTexField(
                          isInLoggin: true,
                          hint: "Password",
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              password = value;
                              return null;
                            }
                            return "Campo vacio";
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {
                        // final route = MaterialPageRoute(builder: (context) => VideoList());
                        // Navigator.push(context, route);

                        _formKey.currentState?.save();
                        if (_formKey.currentState?.validate() ?? false) {
                          print(username);
                          print(password);
                          final isUserAllow = userLoggin.checkUserLoggin(username: username, password: password);

                          if (isUserAllow) {
                            print("NAVEGAR");
                          } else {
                            print("NO PERMITIDO");
                          }
                        }
                      },
                      child: Text("Ingresar como usuario")),
                  ElevatedButton(onPressed: () {}, child: Text("Ingresar como invitado")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
