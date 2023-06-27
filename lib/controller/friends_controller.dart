import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendsController {
  // Get user data
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        return userData.data() as Map<String, dynamic>;
      } else {
        print('User data not found.');
        return null;
      }
    } catch (error, stackTrace) {
      print('Error getting user data: $error\n$stackTrace');
      return null;
    }
  }

  // Store user data in the "friends" collection
  Future<void> storeUserDataAsFriend(String uid) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('User not signed in.');
        return;
      }

      final userData = await getUserData(uid);
      if (userData != null) {
        await FirebaseFirestore.instance
            .collection('friends')
            .doc(currentUser.uid)
            .set(userData);
        print('User data stored as a friend.');
      }
    } catch (error) {
      print('Error storing user data as a friend: $error');
    }
  }
}
