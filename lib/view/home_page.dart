import 'package:chatapp/view/chat_room.dart';
import 'package:chatapp/view/login_page.dart';
import 'package:chatapp/view/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/auth_google.dart';

//this before

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
        appBar: AppBar(
          title: const Text('DocTalk App'),
          backgroundColor: Colors.red,
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
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 50,
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _search,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: "Cari",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: const Text('Cari'),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  final userData = _searchResults?.docs[index].data()
                      as Map<String, dynamic>;

                  return ListTile(
                    title: Text(userData['displayName']),
                    subtitle: Text(userData['email']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChatroomPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.group_add_sharp),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
