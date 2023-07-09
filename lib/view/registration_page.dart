// ignore_for_file: library_private_types_in_public_api

import 'package:chatapp/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({Key? key}) : super(key: key);

  @override
  _RegistrationFormPageState createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final ProfileController _controller = ProfileController();
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

  void _submitForm() {
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

    _controller.submitForm(
      context,
      userId: userId,
      displayName: displayName,
      email: email,
      name: name,
      address: address,
      spesialisasi: spesialisasi,
      license: license,
      bio: bio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
      ),
    );
  }
}
