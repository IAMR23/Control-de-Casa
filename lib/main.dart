import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foco_led_app/firebase_options.dart';
import 'widgets/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foco LED',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainNavigation(),
    );
  }
}
