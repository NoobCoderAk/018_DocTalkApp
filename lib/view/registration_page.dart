// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:chatapp/controller/auth_google.dart';
import 'package:chatapp/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({Key? key}) : super(key: key);

  @override
  _RegistrationFormPageState createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  AuthGoogle authGoogle = AuthGoogle();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _spesialisasiController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _spesialisasiController.dispose();
    _licenseController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    // Handle form submission
    String name = _nameController.text;
    String address = _addressController.text;
    String spesialisasi = _spesialisasiController.text;
    String license = _licenseController.text;
    String bio = _bioController.text;

    // Get the current user's ID and display name
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;
    final String displayName = user.displayName ?? '';
    final String email = user.email ?? '';

    try {
      // Store data in Firebase collection
      await FirebaseFirestore.instance
          .collection('Registration Files')
          .doc(user.uid)
          .set({
        'uid': userId,
        'description': name,
        'displayName': displayName,
        'email': email,
        'address': address,
        'spesialisasi': spesialisasi,
        'license': license,
        'bio': bio,
      });

      // // Reset the form after successful submission
      _nameController.clear();
      _addressController.clear();
      _spesialisasiController.clear();
      _licenseController.clear();
      _bioController.clear();

      // Navigate to the home page
      // ignore: use_build_context_synchronously
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      // Handle any errors that occur during submission
      print('Error submitting form: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
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
              controller: _licenseController,
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
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
