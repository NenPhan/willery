import 'package:flutter/material.dart';
import 'package:willery/app/app_config.dart';
import 'package:willery/app/my_app.dart';

void main() {
  runApp(AppConfig(
    appName: 'Willery',
    flavorName: AppFlavor.DEVELOPMENT,
    apiUrl: 'apiUrl',
    child: const MyApp(),
  ));
}
