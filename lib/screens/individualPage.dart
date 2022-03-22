import 'dart:io';

import 'package:chats/CustomUI/own_message.dart';
import 'package:chats/CustomUI/reply_card.dart';
import 'package:chats/Model/Chatmodel.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  IO.Socket? socket;

  final TextEditingController _controller = TextEditingController();

  void connect() {}

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white54),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, size: 24),
                    CircleAvatar(
                        child: Icon(
                            widget.chatModel.isGroup!
                                ? Icons.groups
                                : Icons.person,
                            color: Colors.white),
                        radius: 20,
                        backgroundColor: Colors.blueGrey)
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name!,
                        style: TextStyle(
                            fontSize: 18.5, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Last seen today at 12:05",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                PopupMenuButton<String>(
                    padding: EdgeInsets.all(0),
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext context) {
                      return const [
                        PopupMenuItem(
                            child: Text("View Contact"),
                            value: ("View Contact")),
                        PopupMenuItem(
                            child: Text("Media, Links and docs"),
                            value: ("Media, Links and docs")),
                        PopupMenuItem(
                            child: Text("Whatsapp Web"),
                            value: ("Whatsapp Web")),
                        PopupMenuItem(child: Text("Search"), value: ("Search")),
                        PopupMenuItem(
                            child: Text("Mute Notification"),
                            value: ("Mute Notifications")),
                        PopupMenuItem(
                            child: Text("Wallpaper"), value: ("Wallpaper")),
                      ];
                    })
              ],
            ),
          ),
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WillPopScope(
                onWillPop: () {
                  if (show) {
                    setState(() {
                      show = false;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  return Future.value(false);
                },
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 140,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          OwnerMessage(),
                          ReplyCard(),
                          OwnerMessage(),
                          ReplyCard(),
                          OwnerMessage(),
                          ReplyCard(),
                          OwnerMessage(),
                          ReplyCard(),
                          OwnerMessage(),
                          ReplyCard(),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            prefixIcon: IconButton(
                                                icon:
                                                    Icon(Icons.emoji_emotions),
                                                onPressed: () {
                                                  focusNode.unfocus();
                                                  focusNode.canRequestFocus =
                                                      false;
                                                  setState(() {
                                                    show = !show;
                                                  });
                                                }),
                                            suffixIcon: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) =>
                                                                bottomsheet());
                                                      },
                                                      icon: Icon(
                                                          Icons.attach_file)),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.camera_alt)),
                                                ]),
                                            contentPadding:
                                                EdgeInsets.all(5))))),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, right: 2, left: 2),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xff128c7e),
                                child: IconButton(
                                  icon: const Icon(Icons.mic),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ]),
                          show
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.38,
                                  child: emojiSelect())
                              : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    ]);
  }

  Widget bottomsheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconcreation(
                    Icons.insert_drive_file, Colors.indigo, "Documents"),
                iconcreation(Icons.camera_alt, Colors.pink, "Camera"),
                iconcreation(Icons.insert_photo, Colors.purple, "Gallery")
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconcreation(Icons.headset, Colors.orange, "Audio"),
                iconcreation(Icons.location_pin, Colors.pink, "Location"),
                iconcreation(Icons.person, Colors.purple, "Contact")
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
              radius: 30, backgroundColor: color, child: Icon(icon, size: 29)),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 12))
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (Category category, Emoji emoji) {
        _onEmojiSelected(emoji);
      },
      onBackspacePressed: _onBackspacePressed,
      config: Config(
        columns: 7,
        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
        // verticalSpacing: 0,
        // horizontalSpacing: 0,
        // initCategory: Category.RECENT,
        // bgColor: Color(0xFFF2F2F2),
        // indicatorColor: Colors.blue,
        // iconColor: Colors.grey,
        // iconColorSelected: Colors.blue,
        // progressIndicatorColor: Colors.blue,
        // backspaceColor: Colors.blue,
        // skinToneDialogBgColor: Colors.white,
        // skinToneIndicatorColor: Colors.grey,
        // enableSkinTones: true,
        // showRecentsTab: true,
        // recentsLimit: 28,
        // noRecentsText: "No Recents",
        // noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
        // tabIndicatorAnimDuration: kTabScrollDuration,
        // categoryIcons: const CategoryIcons(),
        // buttonMode: ButtonMode.MATERIAL
      ),
    );
  }
}
