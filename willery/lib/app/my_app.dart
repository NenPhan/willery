import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:willery/app/app_config.dart';
import 'package:willery/pages/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({this.useResponsiveWrapper = false, Key? key}) : super(key: key);
  final bool useResponsiveWrapper;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
      onTap: () {
        hidePanel(context);
        // disableFocus(context, () async {});
      },
      child: const MaterialApp(
        title: 'Willery',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [],
        home: Home(),
      ),
    );
  }
}
