import 'dart:io';

import 'package:chat_app/constrain/constrain.dart';
import 'package:chat_app/helper/firebase_db.dart';
import 'package:chat_app/screen/chat_screen/ui/item_message.dart';
import 'package:chat_app/screen/splash_screen.dart/auth_bloc/auth_bloc.dart';
import 'package:chat_app/until/app_bar.dart';
import 'package:chat_app/until/app_button.dart';
import 'package:chat_app/until/app_color.dart';
import 'package:chat_app/until/app_icon.dart';
import 'package:chat_app/until/app_textfield.dart';
import 'package:chat_app/until/circle_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DataChatScreen {
  final String chatRoomId;
  final Map<String, dynamic> user;
  DataChatScreen({required this.chatRoomId, required this.user});
}

class ChatScreen extends StatefulWidget {
  final DataChatScreen data;
  const ChatScreen({Key? key, required this.data}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatController = TextEditingController();
  final FocusNode _chatFocusNode = FocusNode();
  AuthBloc? authBloc;
  String? codeName;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);

    codeName = widget.data.user["name"][0];
  }

  @override
  void dispose() {
    super.dispose();
    _chatController.dispose();
    _chatFocusNode.dispose();
  }

  void sendTextMessage() async {
    Map<String, dynamic> message = <String, dynamic>{
      "sendBy": authBloc!.state.user!.uid,
      "message": _chatController.text,
      "type": "text",
      "time": FieldValue.serverTimestamp(),
    };

    _chatController.clear();
    await AppFirebaseDB().addMessageToChatRoom(widget.data.chatRoomId, message);
  }

  Future<File?> getImageFromGallery() async {
    File? image;
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = File(value.path);
      }
    });
    return image;
  }

  void sendImageMessage(File? file) async {
    if (file != null) {
      await AppFirebaseDB().addImageToChatRoom(file, widget.data.chatRoomId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        leftBarButtonItem: AppButton.icon(
          icon: AppIcon.back,
          iconColor: AppColors.darkThemeColor,
          onPressed: () => Future.delayed(
            ConstrainApp.kdefaultDuration,
            () => Navigator.pop(context),
          ),
        ),
        titleWidget: ListTile(
          minLeadingWidth: 2.0,
          horizontalTitleGap: 10.0,
          contentPadding: const EdgeInsets.all(0.0),
          leading: CircleAvatarUser(widget.data.user['name'][0]),
          title: Text(
            widget.data.user['name'],
            style: theme.textTheme.headline5,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.backgroundColor,
              theme.backgroundColor,
              const Color(0xFFE6E6E6),
            ],
          ),
        ),
        child: Column(
          children: [
            const Divider(color: AppColors.darkThemeColor, height: 0.0),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: AppFirebaseDB()
                    .getListMessageFromChatRoom(widget.data.chatRoomId),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) => ItemMessage(
                        widget.data.user,
                        <String, dynamic>{
                          "message": snapshot.data!.docs[index]["message"],
                          "sendBy": snapshot.data!.docs[index]["sendBy"],
                          "type": snapshot.data!.docs[index]["type"],
                        },
                      ),
                    );
                  }
                  return const Center(child: SizedBox.shrink());
                },
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await getImageFromGallery().then((value) async {
                      sendImageMessage(value);
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(AppIcon.image),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: AppTextField.common(
                      controller: _chatController,
                      focusNode: _chatFocusNode,
                      hintText: '....',
                      boder: InputBorder.none,
                      radiusBorder: 20.0,
                      backgroundColor: AppColors.subLightColor.withOpacity(0.1),
                    ),
                  ),
                ),
                AppButton.icon(
                  icon: AppIcon.send,
                  iconColor: theme.primaryColor,
                  onPressed: () {
                    if (_chatController.text.isNotEmpty) {
                      sendTextMessage();
                    }
                  },
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
