import 'package:chats/CustomUI/avatar_card.dart';
import 'package:chats/CustomUI/button_card.dart';
import 'package:chats/CustomUI/contact_card.dart';
import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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

    List<ChatModel> group = [];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("New Group",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Add participants",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Stack(children: [
        ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(height: group.length > 0 ? 90 : 10);
              }
              return InkWell(
                  onTap: () {
                    setState(() {
                      if (contacts[index - 1].select == true) {
                        group.remove(contacts[index - 1]);
                        contacts[index - 1].select = false;
                      } else {
                        group.add(contacts[index - 1]);
                        contacts[index - 1].select = true;
                      }
                    });
                  },
                  child: ContactCard(contact: contacts[index - 1]));
            }),
        group.isNotEmpty
            ? Column(
                children: [
                  Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      group.remove(contacts[index]);
                                      contacts[index].select = false;
                                    });
                                  },
                                  child: AvatarCard(contact: contacts[index]));
                            } else {
                              return Container();
                            }
                          })),
                  const Divider(thickness: 1)
                ],
              )
            : Container()
      ]),
    );
  }
}
