// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    Key? key,
    required this.appName,
    required this.flavorName,
    required this.apiUrl,
    required Widget child,
  }) : super(key: key, child: child) {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (isDevelopment) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack ?? StackTrace.fromString("stackTraceString"));
      }
    };
  }

  final String appName;
  final AppFlavor flavorName;
  final String apiUrl;
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => const SizedBox(),
  );

  bool get isDevelopment => flavorName == AppFlavor.DEVELOPMENT || flavorName == AppFlavor.STAGING_DEV;

  static AppConfig? instance(BuildContext context) => context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

// ignore: constant_identifier_names
enum AppFlavor { DEVELOPMENT, TEST, PRODUCTION, STAGING, STAGING_DEV }

void hidePanel(BuildContext context) {
  if (AppConfig.instance(context)!.overlayEntry.mounted) {
    AppConfig.instance(context)!.overlayEntry.remove();
  }
}
