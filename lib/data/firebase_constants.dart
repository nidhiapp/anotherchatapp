import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';

class FbConstants {
  static late ChatUserModel myself;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firestorage = FirebaseStorage.instance;

  static User? get currentUser {
    if (auth.currentUser != null) {
      return auth.currentUser!;
    }
    return FirebaseAuth.instance.currentUser!;
  }
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
        .doc(currentUser!.uid)
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
        id: currentUser!.uid.toString(),
        email: currentUser!.email.toString(),
        name: currentUser!.displayName.toString(),
        about: " lets use this amazing app", //currentUser.email.toString(),
        image: currentUser!.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(currentUser!.uid)
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
        .where('id', isNotEqualTo: currentUser!.uid)
        .snapshots();
  }

  //for updating information
  static Future<void> updateCurrentUserInfo() async {
    await firestore
        .collection('users')
        .doc(currentUser!.uid)
        .update({'name': myself.name, 'about': myself.about});
  }

  //update profile picture of user

  static Future<void> updateProfilePicture(File file) async {
    final extension = file.path.split('.').last;
    debugPrint('Extension: $extension');
    final ref = firestorage
        .ref()
        .child('profile pictures/${currentUser!.uid}.$extension');
    ref
        .putFile(file, SettableMetadata(contentType: 'image/$extension'))
        .then((p0) async {
      debugPrint("Data Transfereed: ${p0.bytesTransferred / 1000}kb");

      //updating image in firestore database
      myself.image = await ref.getDownloadURL();
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'image': myself.image, 'about': myself.about});
    });
  }

//********************** here comes chat related Apis ***********************/

  //creating messages model
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUserModel targetUser) {
    return firestore
        .collection(
            'chats/ ${getConversationIdOFusers(targetUser.id)}/messages/')
        .snapshots();
  }

  ///functionality to implement sending and receiving messages-----------------------
  ///designing a specific user id for convo between two users----
  ///
  static String getConversationIdOFusers(String id) =>
      currentUser!.uid.hashCode <= id.hashCode
          ? '${currentUser!.uid}_$id'
          : '${id}_${currentUser!.uid}';

  // TO send MESSSAGES
  //
  static Future<void> sendMessages(
      ChatUserModel targetUser, String msg, Type type) async {
    final timeorMessageid = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModel message = MessageModel(
      // id: timeorMessageid,
      isSelected: false,
      msg: msg,
      read: ' ',
      sendTo: targetUser.id,
      type: type,
      sent: timeorMessageid,
      sendBy: currentUser!.uid,
      isPinned: false,
      isStarred: false,
      isDeleted: false, // Assuming the message is not deleted initially
      forwardedFrom: '', // Assuming it's not forwarded initially
      replyToMessageId: '', // Assuming it's not a reply initiall
    );
    final ref = firestore.collection(
        'chats/ ${getConversationIdOFusers(targetUser.id)}/messages/');
    await ref.doc(timeorMessageid).set(message.toJson());
  }

  static Future<void> updateMessageStatus(MessageModel chats) async {
    await firestore
        .collection(
            'chats/ ${getConversationIdOFusers(chats.sendBy)}/messages/')
        .doc(chats.sent)
        .update({"read": DateTime.now().microsecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMesasge(
      ChatUserModel targetUser) {
    return firestore
        .collection(
            'chats/ ${getConversationIdOFusers(targetUser.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //for chatimages
  static void sendChatImage(ChatUserModel chatUser, File file) async {
    final extension = file.path.split('.').last;
    debugPrint('Extension: $extension');
    final ref = firestorage.ref().child(
        'images/${getConversationIdOFusers(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$extension');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$extension'))
        .then((p0) async {
      debugPrint("Data Transfereed: ${p0.bytesTransferred / 1000}kb");

      //updating image in firestore database
      final imgUrl = await ref.getDownloadURL();
      await sendMessages(chatUser, imgUrl, Type.image);
    });
  }

  /////----------------get last active time of user-------------------//////////
  static Stream<QuerySnapshot<Map<String, dynamic>>> usersInfo(
      ChatUserModel chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    return firestore.collection('users').doc(currentUser!.uid).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

//   static Future<void> deleteMessageFromBothSides(MessageModel chats) async {
//   // Delete the message from the sender's chat
//   await firestore
//       .collection('chats/${getConversationIdOFusers(chats.sendTo)}/messages/')
//       .doc(chats.sent)
//       .delete();

//   // Delete the same message from the receiver's chat
//   await firestore
//       .collection('chats/${getConversationIdOFusers(chats.sendBy)}/messages/')
//       .doc(chats.sent)
//       .delete();

//   // If msg is an image, also delete it from Firebase Storage.
//   if (chats.type == Type.image) {
//     await firestorage.refFromURL(chats.msg).delete();
//   }
// }

  static Future<void> deleteMessage(MessageModel chats) async {
    // final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore
        .collection(
            'chats/ ${getConversationIdOFusers(chats.sendTo)}/messages/')
        .doc(chats.sent)
        .delete();
    //if msg is an image
    await firestorage.refFromURL(chats.msg).delete();
  }

  static Future<void> deleteOthersMessage(
    MessageModel chats,
  ) async {
    // final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore
        .collection(
            'chats/ ${getConversationIdOFusers(chats.sendTo)}/messages/')
        .doc(chats.read)
        .delete();
    //if msg is an image
    await firestorage.refFromURL(chats.msg).delete();
  }

//update message

  static Future<void> updateMessage(
      MessageModel chats, String updatedMsg) async {
    // final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore
        .collection(
            'chats/ ${getConversationIdOFusers(chats.sendTo)}/messages/')
        .doc(chats.sent)
        .update({'msg': updatedMsg});
    //if msg is an image
    //await firestorage.refFromURL(chats.msg).delete();
  }

  ///delete for all messages

  static Future<void> deleteMessageForEveryone(
      MessageModel chats, MessageModel chatUser) async {
    await firestore
        .collection(
            'chats/ ${getConversationIdOFusers(chatUser.sendTo)}/messages/')
        .doc(chats.sent)
        .delete();
  }

  static Future<void> deleteReceivedMessageForMe(
    MessageModel receivedMessage,
  ) async {
    // Delete the received message from your chat collection
    await firestore
        .collection(
            'chats/${getConversationIdOFusers(receivedMessage.sendTo)}/messages/')
        .doc(receivedMessage.sent)
        .delete();
  }
}
