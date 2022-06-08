import 'package:chats/Model/Chatmodel.dart';
import 'package:chats/Pages/Chat_page.dart';
import 'package:flutter/material.dart';

import '../Pages/Camera_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Whatsapp"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem(child: Text("New group"), value: ("New group")),
              PopupMenuItem(child: Text("New broadcast"), value: ("New group")),
              PopupMenuItem(
                  child: Text("Whatsapp Web"), value: ("Whatsapp Web")),
              PopupMenuItem(
                  child: Text("Starred messages"), value: ("Starred messages")),
              PopupMenuItem(child: Text("Settings"), value: ("Settings")),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS")
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            sourchat: widget.sourcechat,
            chatmodels: widget.chatmodels,
          ),
          Text("status"),
          Text("calls")
        ],
      ),
    );
  }
}
