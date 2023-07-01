import 'package:chatapp/view/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final String currentUserId = currentUser!.uid;

    return Scaffold(
      backgroundColor: HexColor("#212A3E"),
      appBar: AppBar(
        leading: BackButton(
          color: HexColor("#ffffff"), // <-- SEE HERE
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: HexColor("#ffffff"),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HexColor("#27374D"),
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
                  ListTile(
                    // tileColor: Colors.red,
                    title: Text(
                      'Username:',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['displayName']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Nama Panjang',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // tileColor: Colors.amber,
                    subtitle: Text(
                      'Name: ${data['name']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    // tileColor: Colors.blue,
                    title: Text(
                      'Email: ',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['email']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    // tileColor: Colors.green,
                    title: Text(
                      'Alamat:',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['address']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    // tileColor: Colors.orange,
                    title: Text(
                      'Spesialisasi: ',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['spesialisasi']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    // tileColor: Colors.teal,
                    title: Text(
                      'Lisensi: ',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Lisensi: ${data['license']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    // tileColor: Colors.amber,
                    title: Text(
                      'Bio:',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['bio']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
