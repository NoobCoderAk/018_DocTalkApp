// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfile extends StatefulWidget {
  final String? displayName;
  final String? name;
  final String? email;
  final String? address;
  final String? spesialisasi;
  final String? license;
  final String? bio;

  const UpdateProfile({
    Key? key,
    required this.displayName,
    required this.name,
    required this.email,
    required this.address,
    required this.spesialisasi,
    required this.license,
    required this.bio,
  }) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController _displayNameController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _spesialisasiController;
  late TextEditingController _lisensiController;
  late TextEditingController _bioController;
  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: widget.displayName);
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _addressController = TextEditingController(text: widget.address);
    _spesialisasiController = TextEditingController(text: widget.spesialisasi);
    _lisensiController = TextEditingController(text: widget.license);
    _bioController = TextEditingController(text: widget.bio);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _spesialisasiController.dispose();
    _lisensiController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _updateUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserId = currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('Registration Files')
          .doc(currentUserId)
          .update({
        'displayName': _displayNameController.text,
        'name': _nameController.text,
        'email': _emailController.text,
        'address': _addressController.text,
        'spesialisasi': _spesialisasiController.text,
        'license': _lisensiController.text,
        'bio': _bioController.text,
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
              enabled: true,
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Nama Panggilan',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              enabled: false,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
            TextFormField(
              controller: _spesialisasiController,
              decoration: const InputDecoration(
                labelText: 'Spesialisasi',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _lisensiController,
              decoration: const InputDecoration(
                labelText: 'Surat Izin Praktek',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
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
