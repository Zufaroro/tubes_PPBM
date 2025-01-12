import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_cat/main.dart';
import 'package:cat_cat/percobaan/api/apis.dart';
import 'package:cat_cat/percobaan/helper/my_date_util.dart';
import 'package:cat_cat/percobaan/models/message.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  //another user message
  Widget _blueMessage() {
    //update last read message if sender and receiver are different
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      log('message read updated');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: Color.fromRGBO(
                    245, 202, 195, 1), //Color.fromRGBO(245, 202, 195, 1)
                border: Border.all(
                    color: Color.fromRGBO(
                        255, 117, 120, 1)), //rgba(255, 117, 120, 1)
                //making the borders curved
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ? Text(
                    widget.message.message,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .03),
                    child: CachedNetworkImage(
                      width: mq.height * .05,
                      height: mq.height * .05,
                      imageUrl: widget.message.message,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        size: 70,
                      ),
                    ),
                  ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: mq.width * .04, bottom: mq.height * .01),
          child: Row(
            children: [
              Text(
                MyDateUtil.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        )
      ],
    );
  }

  //user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //time
        Padding(
          padding:
              EdgeInsets.only(left: mq.width * .04, bottom: mq.height * .01),
          child: Row(
            children: [
              //for adding some space
              SizedBox(width: mq.width * .04),

              //double tick blue icon for message read
              if (widget.message.read.isNotEmpty)
                Icon(
                  Icons.done_all_rounded,
                  color: Colors.blue,
                  size: 20,
                ),

              //for adding some space
              SizedBox(width: 2),

              //sent time
              Text(
                MyDateUtil.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: Color.fromRGBO(
                    246, 189, 96, 1), //Color.fromRGBO(245, 202, 195, 1)
                border: Border.all(
                    color: Color.fromRGBO(
                        255, 188, 17, 1)), //rgba(255, 117, 120, 1)
                //making the borders curved
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ? Text(
                    widget.message.message,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.message,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        size: 70,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  //show message update dialog
//   void _showMessageUpdateDialog() {
//     String email = '';

//     showDialog(
//   context: context,
//   builder: (_) => AlertDialog(
//     contentPadding: const EdgeInsets.only(
//         left: 24, right: 24, top: 20, bottom: 10), // EdgeInsets.only
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)), // RoundedRectangleBorder

//     // Title
//     title: Row(
//       children: const [
//         Icon(
//           Icons.message,
//           color: Colors.blue,
//           size: 28,
//         ),
//         SizedBox(width: 8), // Add spacing between icon and text
//         Text(
//           'Update Message',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ],
//     ),

//     // Content
//     content: TextFormField(
//       initialValue: updatedMsg,
//       maxLines: null,
//       onChanged: (value) => updatedMsg = value,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         hintText: 'Enter your message',
//       ),
//     ),

//     // Actions
//     actions: [
//       // Cancel button
//       MaterialButton(
//         onPressed: () {
//           // Hide alert dialog
//           Navigator.pop(context);
//         },
//         child: const Text(
//           'Cancel',
//           style: TextStyle(color: Colors.blue, fontSize: 16),
//         ),
//       ),

//       // Update button
//       MaterialButton(
//         onPressed: () {
//           // Hide alert dialog and update the message
//           Navigator.pop(context);
//           APIs.updateMessage(widget.message, updatedMsg);
//         },
//         child: const Text(
//           'Update',
//           style: TextStyle(color: Colors.blue, fontSize: 16),
//         ),
//       ),
//     ],
//   ),
// );
//}
}
