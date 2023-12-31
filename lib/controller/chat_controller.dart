// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _messagesRef =
      _firestore.collection('messages');

  void sendMessage(String userId, String message) async {
    try {
      await _messagesRef.add({
        'userId': userId,
        'message': message,
        'timestamp': Timestamp.now(),
      });
    } catch (error) {
      print('Gagal menyimpan perbaruan: $error');
      // Handle the error appropriately, e.g., show an error message
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await _messagesRef.doc(messageId).delete();
    } catch (error) {
      print('Gagal Menghapus Pesan: $error');
      // Handle the error appropriately, e.g., show an error message
    }
  }

  Stream<QuerySnapshot> getChatStream() {
    return _messagesRef.orderBy('timestamp').snapshots();
  }
}
