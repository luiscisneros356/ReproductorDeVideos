import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verifarma/data/local_storage.dart';
import 'package:verifarma/domain/providers/providers.dart';
import 'package:verifarma/presentation/routes/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPersistentFrameCallback((_) {
    //   nav();
    // });
    nav();

    super.initState();
  }

  Future<void> nav() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final check = Boxes.userDataBase.values.isNotEmpty;
      final leng = Boxes.userDataBase.values.length;

      if (check) {
        userProvider.fetchUsers().then((value) =>
            userProvider.setCurrentUser(username: userProvider.usernameDB, password: userProvider.passwordDB));

        Navigator.pushReplacementNamed(context, RoutesApp.home);
      } else {
        Navigator.pushReplacementNamed(context, RoutesApp.auth);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/splash.png");
  }
}
