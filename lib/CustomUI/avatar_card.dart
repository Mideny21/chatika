import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey[200],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 11,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2),
          Text(
            contact.name!,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
