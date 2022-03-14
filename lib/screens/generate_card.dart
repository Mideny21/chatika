import 'package:flutter/material.dart';

class HomeNode extends StatefulWidget {
  @override
  _HomeNodeState createState() => _HomeNodeState();
}

class _HomeNodeState extends State<HomeNode> {
  var listLength = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App :)"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              listLength++;
            });
          }),
      body: Container(
          child: ListView.builder(
              itemCount: listLength,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("$index"),
                  title: Text("List Tile as Widget"),
                );
              })),
    );
  }
}
