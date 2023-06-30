import 'package:chatapp/view/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final String currentUserId = currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Registration Files')
                .doc(currentUserId)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                  child: Text('No data available.'),
                );
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Nama Panggilan: ${data['displayName']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Name: ${data['name']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Email: ${data['email']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Alamat : ${data['address']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Spesialisasi: ${data['spesialisasi']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Lisensi: ${data['license']}'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: 200,
                    color: Colors.amber,
                    child: Text('Bio: ${data['bio']}'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
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
                    },
                    child: const Text('Edit'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
