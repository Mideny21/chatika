import 'package:camera/camera.dart';
import 'package:chats/screens/camera_screens.dart';
import 'package:flutter/material.dart';

import 'screens/LoginScreens.dart';
import 'screens/generate_card.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chats',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: const Color(0xff075e54),
      ),
      home: LoginScreen(),
    );
  }
}
