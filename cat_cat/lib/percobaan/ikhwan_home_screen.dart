import 'dart:convert';
import 'dart:developer';

import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:cat_cat/percobaan/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class IkhwanHomeScreen extends StatefulWidget {
  const IkhwanHomeScreen({super.key});

  @override
  State<IkhwanHomeScreen> createState() => _IkhwanHomeScreenState();
}

class _IkhwanHomeScreenState extends State<IkhwanHomeScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.chevron_left_rounded),
        title: Text('Chat dengan Dokter'),
        backgroundColor: Color.fromARGB(463, 246, 189, 96),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: Container(
        color: Color(0xFFF7EDE5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the search bar
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 5), // Offset of the shadow
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'cari dokter....', // Placeholder text
                    hintStyle: TextStyle(color: Colors.grey), // Hint text style
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey), // Search icon
                    border: InputBorder.none, // Remove default border
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), // Padding
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: APIs.firestore.collection('user').snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      list = data
                              ?.map((e) => ChatUser.fromJson(e.data()))
                              .toList() ??
                          [];
                      // for (var i in data!) {
                      //   log('Data: ${jsonEncode(i.data())}');
                      //   list.add(i.data()['name']);
                      // }

                      if (list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ChatUserCard(user: list[index]);
                              // return Text('Name: ${list[index]}');
                            });
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: Center(
                            child: Text(
                              'No Connection Found!',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
