import 'dart:developer';

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
            padding: EdgeInsets.all(mq.width * .04),
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
            child: Text(
              widget.message.message,
              style: TextStyle(fontSize: 15, color: Colors.black87),
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
            padding: EdgeInsets.all(mq.width * .04),
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
            child: Text(
              widget.message.message,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
