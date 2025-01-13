import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:cat_cat/percobaan/check_out.dart';
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:cat_cat/percobaan/pf.dart';
import 'package:cat_cat/percobaan/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class IkhwanHomeScreen extends StatefulWidget {
  const IkhwanHomeScreen({super.key});

  @override
  State<IkhwanHomeScreen> createState() => _IkhwanHomeScreenState();
}

class _IkhwanHomeScreenState extends State<IkhwanHomeScreen> {
  //for storing all users
  List<ChatUser> _list = [];

  //for storing searched items
  final List<ChatUser> _searchList = [];

  //for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    // Future.delayed(const Duration(seconds: 2), () {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //       systemNavigationBarColor: Colors.white,
    //       statusBarColor: Colors.white));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Chat dengan Dokter'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfileScreen(user: APIs.me)));
                },
                icon: const Icon(Icons.more_vert))
          ],
          backgroundColor: Color.fromARGB(463, 246, 189, 96),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: FloatingActionButton(
        //     onPressed: () async {
        //       _addChatUserDialog();
        //     },
        //     child: const Icon(Icons.add_comment_rounded),
        //   ),
        // ),
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
                    onTap: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    onChanged: (value) {
                      _searchList.clear();
                      for (var i in _list) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'cari dokter....', // Placeholder text
                      hintStyle:
                          TextStyle(color: Colors.grey), // Hint text style
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
                  stream: APIs.getAllUsers(),
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
                        _list = data
                                ?.map((e) => ChatUser.fromJson(e.data()))
                                .where((user) =>
                                    user.isOnline) // Filter only online users
                                .toList() ??
                            [];
                        // for (var i in data!) {
                        //   log('Data: ${jsonEncode(i.data())}');
                        //   list.add(i.data()['name']);
                        // }

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              itemCount: _isSearching
                                  ? _searchList.length
                                  : _list.length,
                              padding: EdgeInsets.only(top: mq.height * .01),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ChatUserCard(
                                    user: _isSearching
                                        ? _searchList[index]
                                        : _list[index]);
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
      ),
    );
  }

  // void _addChatUserDialog() {
  //   String email = '';

  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       contentPadding: const EdgeInsets.only(
  //           left: 24, right: 24, top: 20, bottom: 10), // EdgeInsets.only
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20)), // RoundedRectangleBorder

  //       // Title
  //       title: Row(
  //         children: const [
  //           Icon(
  //             Icons.person_add,
  //             color: Colors.amber,
  //             size: 28,
  //           ),
  //           SizedBox(width: 8), // Add spacing between icon and text
  //           Text(
  //             'Add User',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ),

  //       // Content
  //       content: TextFormField(
  //         maxLines: null,
  //         onChanged: (value) => email = value,
  //         decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             hintText: 'Email',
  //             prefixIcon: Icon(
  //               Icons.email_rounded,
  //               color: Colors.amber,
  //             )),
  //       ),

  //       // Actions
  //       actions: [
  //         // Cancel button
  //         MaterialButton(
  //           onPressed: () {
  //             // Hide alert dialog
  //             Navigator.pop(context);
  //           },
  //           child: const Text(
  //             'Cancel',
  //             style: TextStyle(color: Colors.amber, fontSize: 16),
  //           ),
  //         ),

  //         // add button
  //         MaterialButton(
  //           onPressed: () {
  //             // Hide alert dialog and update the message
  //             Navigator.pop(context);
  //             // APIs.updateMessage(widget.message, updatedMsg);
  //           },
  //           child: const Text(
  //             'Add',
  //             style: TextStyle(color: Colors.amber, fontSize: 16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
