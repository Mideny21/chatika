import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);
  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: const Icon(Icons.person, color: Colors.white),
            ),
            contact.select!
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: const CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      title: Text(
        contact.name!,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(contact.status!, style: TextStyle(fontSize: 13)),
    );
  }
}
