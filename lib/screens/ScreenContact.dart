import 'package:chats/CustomUI/button_card.dart';
import 'package:chats/CustomUI/contact_card.dart';
import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';

import 'create_group.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "Dev Stack", status: "A full stack developer"),
      ChatModel(name: "Balram", status: "A flutter developer"),
      ChatModel(name: "Saket", status: "A developer"),
      ChatModel(name: "Dev", status: "App developer"),
      ChatModel(name: "Saket", status: "A developer"),
      ChatModel(name: "Dev", status: "App developer"),
      ChatModel(name: "Saket", status: "A developer"),
      ChatModel(name: "Dev", status: "App developer"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Select Contact",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Text("256 Contacts",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                      child: Text("Invite a friend"),
                      value: ("Invite a friend")),
                  PopupMenuItem(child: Text("Contacts"), value: ("Contacts")),
                  PopupMenuItem(child: Text("Refresh"), value: ("Refresh")),
                  PopupMenuItem(child: Text("Help"), value: ("Help")),
                ];
              })
        ],
      ),
      body: ListView.builder(
          itemCount: contacts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => CreateGroup()));
                  },
                  child: ButtonCard(icon: Icons.group, name: "New Group"));
            } else if (index == 1) {
              return ButtonCard(icon: Icons.person_add, name: "New Contact");
            }
            return ContactCard(contact: contacts[index - 2]);
          }),
    );
  }
}
