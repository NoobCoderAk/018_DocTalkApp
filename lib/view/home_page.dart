import 'package:chatapp/view/chat_room.dart';
import 'package:chatapp/view/login_page.dart';
import 'package:chatapp/view/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controller/auth_google.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _search = TextEditingController();
  QuerySnapshot? _searchResults;

  void onSearch() async {
    FirebaseFirestore useraccount;
    useraccount = FirebaseFirestore.instance;
    FirebaseAuth account = FirebaseAuth.instance;

    QuerySnapshot searchSnapshot = await useraccount
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .where("email", isNotEqualTo: account.currentUser!.email)
        .get();
    setState(() {
      _searchResults = searchSnapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#212A3E"),
        appBar: AppBar(
          title: Text(
            'DocTalk App',
            style: TextStyle(
              color: HexColor("#ffffff"),
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: HexColor("#212A3E"),
          actions: [
            IconButton(
              onPressed: () {
                AuthGoogle().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              color: HexColor("#ffffff"),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              color: HexColor("#ffffff"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 50,
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          style: TextStyle(color: HexColor("#ffffff")),
                          controller: _search,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor("#394867"),
                            hintText: "Cari",
                            hintStyle: TextStyle(color: HexColor("#ffffff")),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onSearch,
                    child: const Text(
                      'Cari',
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  color: HexColor("#212A3E"),
                  child: ListView.builder(
                    itemCount: _searchResults?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      final userData = _searchResults?.docs[index].data()
                          as Map<String, dynamic>;

                      return ListTile(
                        // focusColor: Colors.blueAccent,
                        title: Text(
                          userData['displayName'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          userData['email'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ChatroomPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.chat_outlined),
                          color: HexColor("#ffffff"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
