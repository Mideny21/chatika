import 'package:chats/CustomUI/button_card.dart';
import 'package:chats/screens/home.dart';
import 'package:flutter/material.dart';

import '../Model/Chatmodel.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel source;
  List<ChatModel> chatsmodels = [
    ChatModel(
        id: 1,
        name: "Dev Stack",
        icon: Icons.person,
        isGroup: false,
        time: "4:00",
        currentMessage: "Hi Everyone"),
    ChatModel(
        id: 2,
        name: "Kishor",
        icon: Icons.person,
        isGroup: false,
        time: "10:00",
        currentMessage: "Hi Kishor"),
    ChatModel(
        id: 3,
        name: "Collins",
        icon: Icons.person,
        isGroup: true,
        time: "10:00",
        currentMessage: "Hi Dev Collins"),
    ChatModel(
        id: 4,
        name: "Jolins",
        icon: Icons.person,
        isGroup: false,
        time: "10:00",
        currentMessage: "Yo Jollins"),
    // ChatModel(
    //     name: "Peter",
    //     icon: Icons.person,
    //     isGroup: true,
    //     time: "10:00",
    //     currentMessage: "Yo Peter"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chatsmodels.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                source = chatsmodels.removeAt(index);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => HomeScreen(
                              sourcechat: source,
                              chatmodels: chatsmodels,
                            )));
              },
              child: ButtonCard(
                  name: chatsmodels[index].name!, icon: Icons.person))),
    );
  }
}
