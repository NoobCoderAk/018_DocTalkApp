// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:chatapp/model/register_file_model.dart';
import 'package:chatapp/view/home_page.dart';
import 'package:chatapp/view/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/view/update_profile.dart';

class ProfileController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RegisterFileModel _model = RegisterFileModel();

  Stream<DocumentSnapshot> getProfileData(String userId) {
    return _model.getProfileData(userId);
  }

  void navigateToUpdateProfile(
      BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfile(
          displayName: data['displayName'],
          name: data['name'],
          email: data['email'],
          address: data['address'],
          spesialisasi: data['spesialisasi'],
          license: data['license'],
          bio: data['bio'],
        ),
      ),
    );
  }

  void submitForm(
    BuildContext context, {
    required String userId,
    required String displayName,
    required String email,
    required String name,
    required String address,
    required String spesialisasi,
    required String license,
    required String bio,
  }) async {
    try {
      // Store data in Firebase collection
      await _model.submitForm(userId, displayName, email, name, address,
          spesialisasi, license, bio);

      // Reset the form after successful submission

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      // Handle any errors that occur during submission
      print('Error submitting form: $error');
    }
  }

  Future<void> updateUserData(
    BuildContext context, {
    required String currentUserId,
    required String displayName,
    required String name,
    required String email,
    required String address,
    required String spesialisasi,
    required String license,
    required String bio,
  }) async {
    try {
      await _firestore
          .collection('Registration Files')
          .doc(currentUserId)
          .update({
        'displayName': displayName,
        'name': name,
        'email': email,
        'address': address,
        'spesialisasi': spesialisasi,
        'license': license,
        'bio': bio,
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('User data updated successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to update user data.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
