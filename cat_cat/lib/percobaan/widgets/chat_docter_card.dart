import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_cat/main.dart';
import 'package:cat_cat/percobaan/chat_screen.dart';
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:flutter/material.dart';

class ChatDoctorCard extends StatefulWidget {
  final ChatUser user;

  const ChatDoctorCard({super.key, required this.user});

  @override
  State<ChatDoctorCard> createState() => _ChatDoctorCardState();
}

class _ChatDoctorCardState extends State<ChatDoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Colors.amber,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          //user pf picture
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage('assets/image/doctor_sml.png'),
          // ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              width: mq.height * .055,
              height: mq.height * .055,
              imageUrl: widget.user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(
                  backgroundImage: AssetImage('assets/image/man.png')),
            ),
          ),

          //user name
          title: Text(widget.user.name),

          //ratings
          // subtitle: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     buildRatingStars(widget.user.about), // Pass the rating value here
          //     const Text('Rp 40.000/ sesi'),
          //   ],
          // ),

          //chat button
          trailing: TextButton.icon(
            onPressed: () {
              //for navigating to chat screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChatScreen(user: widget.user)));
            },
            icon: const Icon(Icons.chat, color: Colors.red),
            label: const Text(
              'chat',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget buildRatingStars(double rating) {
//   int fullStars = rating.floor(); // Number of full stars
//   bool hasHalfStar =
//       (rating - fullStars) >= 0.5; // Check if there's a half star
//   int emptyStars =
//       5 - fullStars - (hasHalfStar ? 1 : 0); // Remaining empty stars

//   return Row(
//     children: [
//       // Full stars
//       for (int i = 0; i < fullStars; i++)
//         const Icon(Icons.star, color: Colors.amber),
//       // Half star
//       if (hasHalfStar) const Icon(Icons.star_half, color: Colors.amber),
//       // Empty stars
//       for (int i = 0; i < emptyStars; i++)
//         const Icon(Icons.star_border, color: Colors.amber),
//     ],
//   );
// }
