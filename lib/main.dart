import 'package:flutter/material.dart';

import 'screens/generate_card.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
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
      home: HomeScreen(),
    );
  }
}
