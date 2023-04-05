import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'data/repository.dart';
import 'domain/providers/providers.dart';
import 'presentation/material_app.dart';

void main() {
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
