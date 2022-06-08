import 'package:chats/CustomUI/Custom_card.dart';
import 'package:chats/Model/Chatmodel.dart';
import 'package:chats/screens/ScreenContact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.chatmodels, required this.sourchat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Dev Stack",
        icon: Icons.person,
        isGroup: false,
        time: "4:00",
        currentMessage: "Hi Everyone"),
    ChatModel(
        name: "Kishor",
        icon: Icons.person,
        isGroup: false,
        time: "10:00",
        currentMessage: "Hi Kishor"),
    ChatModel(
        name: "Collins",
        icon: Icons.person,
        isGroup: true,
        time: "10:00",
        currentMessage: "Hi Dev Collins"),
    ChatModel(
        name: "Jolins",
        icon: Icons.person,
        isGroup: false,
        time: "10:00",
        currentMessage: "Yo Jollins"),
    ChatModel(
        name: "Peter",
        icon: Icons.person,
        isGroup: true,
        time: "10:00",
        currentMessage: "Yo Peter"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
            chatModel: widget.chatmodels[index], sourchat: widget.sourchat),
      ),
    );
  }
}
