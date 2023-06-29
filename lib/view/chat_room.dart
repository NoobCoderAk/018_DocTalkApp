// ignore_for_file: library_private_types_in_public_api

import 'package:chatapp/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Chatroom'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                        reverse: false, // Display messages in ascending order
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final messageData =
                              message.data() as Map<String, dynamic>;
                          final messageText = messageData['message'] ?? '';
                          final isCurrentUser = messageData['userId'] == userId;

                          return Align(
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
                                  color:
                                      isCurrentUser ? Colors.blue : Colors.grey,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  messageText,
                                  style: TextStyle(
                                    color: isCurrentUser
                                        ? Colors.white
                                        : Colors.black,
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
