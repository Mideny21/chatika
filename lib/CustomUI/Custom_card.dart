import 'package:chats/Model/Chatmodel.dart';
import 'package:chats/screens/individualPage.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(chatModel: chatModel)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(chatModel.isGroup! ? Icons.groups : Icons.person,
                  color: Colors.white),
            ),
            title: Text(
              chatModel.name!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 3),
                Text(chatModel.currentMessage!, style: TextStyle(fontSize: 13))
              ],
            ),
            trailing: Text(chatModel.time!),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1),
          )
        ],
      ),
    );
  }
}
