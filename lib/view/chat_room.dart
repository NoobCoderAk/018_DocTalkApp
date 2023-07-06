// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:chatapp/controller/chat_controller.dart';

class ChatroomPage extends StatefulWidget {
  const ChatroomPage({super.key});

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
      backgroundColor: HexColor("#212A3E"),
      appBar: AppBar(
        leading: BackButton(
          color: HexColor("#ffffff"),
        ),
        title: Text(
          'Chatroom',
          style: TextStyle(
            color: HexColor("#ffffff"),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HexColor("#27374D"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatController!.getChatStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  // Display messages in ascending order
                  reverse: false,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final messageData = message.data() as Map<String, dynamic>;
                    final messageText = messageData['message'] ?? '';
                    final isCurrentUser = messageData['userId'] == userId;

                    return Dismissible(
                      //swipe for delete
                      key: Key(message.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: isCurrentUser
                          ? DismissDirection.endToStart
                          : DismissDirection.none,
                      onDismissed: (direction) {
                        if (isCurrentUser) {
                          _chatController!.deleteMessage(message.id);
                        }
                      },
                      child: Align(
                        //align user chat position
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              // differentiate color for each user box color
                              color: isCurrentUser
                                  ? HexColor("#1C82AD")
                                  : HexColor("#86A3B8"),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              messageText,
                              style: TextStyle(
                                // differentiate color for each user test color
                                color:
                                    isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan disini..',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _chatController!.sendMessage(userId, message);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
