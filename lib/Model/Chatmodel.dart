import 'package:flutter/material.dart';

class ChatModel {
  String? name;
  IconData? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  ChatModel({
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
  });
}
