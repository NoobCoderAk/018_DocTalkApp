// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile(
      {super.key,
      required displayName,
      required name,
      required email,
      required address,
      required spesialisasi,
      required license,
      required bio});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Load current user data
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final userData = documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = userData['name'];
        _addressController.text = userData['address'];
      }
    });
  }

  void _updateUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'name': _nameController.text,
        'address': _addressController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateUserData,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
