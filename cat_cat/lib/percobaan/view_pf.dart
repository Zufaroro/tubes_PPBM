// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_cat/main.dart';
import 'package:cat_cat/percobaan/helper/my_date_util.dart';
import 'package:cat_cat/percobaan/ikhwan_home_screen.dart';
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:cat_cat/percobaan/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => IkhwanHomeScreen()));
              },
            ),
            title: Text(widget.user.name),
            backgroundColor: Color.fromARGB(463, 246, 189, 96),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined on: ',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Text(
                  MyDateUtil.getLastMessageTime(
                      context: context,
                      time: widget.user.createdAt,
                      showYear: true),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 16))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //for adding some space
                  SizedBox(width: mq.width, height: mq.height * .03),

                  //user pf picture
                  // leading: CircleAvatar(
                  //   backgroundImage: AssetImage('assets/image/doctor_sml.png'),
                  // ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.cover,
                      imageUrl: widget.user.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/image/doctor_sml.png')),
                    ),
                  ),

                  SizedBox(height: mq.height * .03),

                  Text(
                    widget.user.email,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),

                  SizedBox(height: mq.height * .03),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: mq.width * .15),
                        child:
                            buildRatingStars(widget.user.about, starSize: 50),
                      ),
                      SizedBox(height: mq.height * .03),
                      const Text('Rp 40.000/ sesi',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),

                  // TextFormField(
                  //   initialValue: widget.user.name,
                  //   onSaved: (val) => APIs.me.name = val ?? '',
                  //     validator: (val) => val != null && val.isNotEmpty
                  //         ? null
                  //         : 'Required Filled',
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(
                  //         Icons.person,
                  //         color: Colors.amber,
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //         borderSide:
                  //             const BorderSide(color: Colors.amber, width: 2.0),
                  //       ),
                  //       hintText: 'eg. Ikhwan Zufar',
                  //       label: Text('Name')),
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}
