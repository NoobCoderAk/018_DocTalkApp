// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chatapp/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final String currentUserId = currentUser!.uid;
    final ProfileController _controller = ProfileController();

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
            stream: _controller.getProfileData(currentUserId),
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
              final String profilePictureUrl = currentUser.photoURL ?? '';

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // alignment: Alignment.center,
                          // height: 60,
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  profilePictureUrl,
                                ),
                                radius: 40,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${data['displayName']}',
                                style: TextStyle(
                                  color: HexColor("#ffffff"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      'Nama Panjang:',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data['name']}',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.navigateToUpdateProfile(context, data);
                    },
                    child: const Text('Edit'),
                  ),
                  const SizedBox(
                    height: 20,
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
