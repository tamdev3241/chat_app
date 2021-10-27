import 'dart:developer';
import 'dart:io';

import 'package:chat_app/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AppFirebaseDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add new user to DB
  Future addUserToDB(User? user) async {
    try {
      await _firestore.collection('users').doc(user!.uid).set({
        'name': user.email!.replaceAll("@gmail.com", ''),
        'email': user.email,
        'uid': user.uid,
        'status': 'Unavalible',
      });
      return user;
    } catch (e) {
      log(e.toString());
    }
  }

  /// get all user from DB
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllUserFormDB() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list = [];
    await _firestore
        .collection('users')
        .get()
        .then((value) => list = value.docs);
    return list;
  }

  /// get all message from chat room
  Stream<QuerySnapshot<Map<String, dynamic>>> getListMessageFromChatRoom(
      String chatRoomId) async* {
    yield* _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  /// add message to chat room
  Future addMessageToChatRoom(
    String chatRoomId,
    Map<String, dynamic> message,
  ) async {
    return await _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(message);
  }

  Future addImageToChatRoom(File fileImage, String chatRoomId) async {
    final String fileName = fileImage.path;
    String imageId = const Uuid().v1();
    int isStatus = 1;
    await _firestore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(imageId)
        .set({
      "sendBy": AppFireBaseAuthService().getCurrenUser()!.uid,
      "message": "",
      "type": "image",
      "time": FieldValue.serverTimestamp(),
    });
    var ref = FirebaseStorage.instance.ref().child('image').child(fileName);

    var uploadTask = await ref.putFile(fileImage).catchError((e) async {
      await _firestore
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(imageId)
          .delete();

      isStatus = 0;
    });

    if (isStatus == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(imageId)
          .update({"message": imageUrl});

      log(imageUrl);
    }
  }
}
