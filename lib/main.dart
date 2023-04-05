import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:verifarma/data/local_storage.dart';

import 'data/repository.dart';
import 'domain/providers/providers.dart';
import 'presentation/material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Boxes.initData();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideosProvider(VideoRepository())),
        ChangeNotifierProvider(create: (_) => UserProvider(UserLogginRepository()))
      ],
      child: const MyApp(),
    ),
  );
}
