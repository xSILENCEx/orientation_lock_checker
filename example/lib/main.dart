import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:orientation_lock_checker/orientation_lock_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDeviceOrientationLocked = false;
  final _orientationLockCheckerPlugin = OrientationLockChecker();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isDeviceOrientationLocked;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isDeviceOrientationLocked =
          await _orientationLockCheckerPlugin.isDeviceOrientationLocked();
    } on PlatformException {
      isDeviceOrientationLocked = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isDeviceOrientationLocked = isDeviceOrientationLocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: initPlatformState,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Text(
                'isDeviceOrientationLocked: $_isDeviceOrientationLocked\n'),
          ),
        ),
      ),
    );
  }
}
