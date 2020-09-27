import 'package:Chat_App/services/auth.dart';
import 'package:Chat_App/views/SearchScreen.dart';
import 'package:Chat_App/views/SignIn.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/ChatRoom';
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.of(context).popAndPushNamed(SignIn.routeName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      /*  body: ListView.builder(
        itemBuilder: (ctx, index) {},
        itemCount: 2,
      ), */
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SearchScreen();
              },
            ),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
