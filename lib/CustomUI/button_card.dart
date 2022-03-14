import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  const ButtonCard({Key? key, required this.name, required this.icon})
      : super(key: key);
  final String name;
  final IconData icon;

  @override
  _ButtonCardState createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff25d366),
          radius: 23,
          child: Icon(widget.icon, size: 26, color: Colors.white),
        ),
        title: Text(widget.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
