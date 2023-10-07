import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';

class FbConstants {
  static late ChatUserModel myself;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get currentUser => auth.currentUser!;
  //static User get chatUser=> auth.use

  static Future<bool> userExists() async {
    return (await firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((currentUser) async {
      if (currentUser.exists) {
        myself = ChatUserModel.fromJson(currentUser.data()!);
        debugPrint(
            '_____________my data: ${currentUser.data()}____________________');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUserModal = ChatUserModel(
        id: currentUser.uid.toString(),
        email: currentUser.email.toString(),
        name: currentUser.displayName.toString(),
        about: " lets use this amazing app", //currentUser.email.toString(),
        image: currentUser.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(currentUser.uid)
        .set(chatUserModal.toJson());
  }

//for getting other users information
  // static Future<void> getChatUserInfo() async {
  //   await firestore.collection("users").doc();
  // }

  //for getting all users from firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: currentUser.uid)
        .snapshots();
  }
}
