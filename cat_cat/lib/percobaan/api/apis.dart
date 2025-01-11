import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //to return current user
  static User get user => auth.currentUser!;

  //for checking if user exist ir not
  static Future<bool> userExists() async {
    return (await firestore.collection('user').doc(auth.currentUser!.uid).get())
        .exists;
  }

  //for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: 4,
        createdAt: time,
        isOnline: false,
        id: user.uid,
        lastActive: time,
        email: user.email.toString(),
        pushToken: '');

    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
}
