// ignore_for_file: library_private_types_in_public_api

import 'package:chatapp/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
  final ProfileController _controller = ProfileController();
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

    _controller.updateUserData(
      context,
      currentUserId: currentUserId,
      displayName: _displayNameController.text,
      name: _nameController.text,
      email: _emailController.text,
      address: _addressController.text,
      spesialisasi: _spesialisasiController.text,
      license: _lisensiController.text,
      bio: _bioController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#212A3E"),
      appBar: AppBar(
        leading: BackButton(
          color: HexColor("#ffffff"),
        ),
        title: Text(
          'Update User Data',
          style: TextStyle(color: HexColor("#ffffff")),
        ),
        backgroundColor: HexColor("#27374D"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                controller: _displayNameController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                enabled: false,
                controller: _emailController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _spesialisasiController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Spesialisasi',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lisensiController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Surat Izin Praktek',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _bioController,
                style: TextStyle(color: HexColor("#ffffff")),
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: HexColor("#ffffff")),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateUserData,
                child: const Text('Update'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
