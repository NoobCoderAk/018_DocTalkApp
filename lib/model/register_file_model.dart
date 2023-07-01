import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterFileModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getProfileData(String userId) {
    return _firestore.collection('Registration Files').doc(userId).snapshots();
  }

  Future<void> submitForm(
    String userId,
    String displayName,
    String email,
    String name,
    String address,
    String spesialisasi,
    String license,
    String bio,
  ) async {
    try {
      // Store data in Firebase collection
      await _firestore.collection('Registration Files').doc(userId).set({
        'uid': userId,
        'name': name,
        'displayName': displayName,
        'email': email,
        'address': address,
        'spesialisasi': spesialisasi,
        'license': license,
        'bio': bio,
      });
    } catch (error) {
      // Handle any errors that occur during submission
      throw Exception('Error submitting form: $error');
    }
  }
}
