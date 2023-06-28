import 'package:chatapp/controller/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatroomPage extends StatefulWidget {
  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  final TextEditingController _messageController = TextEditingController();
  ChatController? _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController();
  }

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatroom'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
