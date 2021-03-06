import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/widgets/PlatformSensitiveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlatformSensitiveDeleteButton extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final String mainButtonText;
  final String secondaryButtonText;
  final Chat chat;
  VoidCallback callback;

  PlatformSensitiveDeleteButton(
      {required this.title,
      required this.chat,
      required this.callback,
      required this.content,
      required this.mainButtonText,
      required this.secondaryButtonText});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context, builder: (context) => this)
        : await showDialog(context: context, builder: (context) => this);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _SetDialogButtons(context),
    );
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _SetDialogButtons(context),
    );
  }

  List<Widget> _SetDialogButtons(BuildContext context) {
    final AllButtons = <Widget>[];
    if (Platform.isIOS) {
      AllButtons.add(CupertinoDialogAction(
          child: Text(secondaryButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          }));
      AllButtons.add(CupertinoDialogAction(
        child: Text(mainButtonText),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats")
              .doc(chat.ChatID)
              .delete();
          callback();
          Navigator.pop(context);
        },
      ));
    } else {
      AllButtons.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(secondaryButtonText)));
      AllButtons.add(TextButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("chats")
                .doc(chat.ChatID)
                .delete();
                callback();
            Navigator.pop(context);
          },
          child: Text(mainButtonText)));
    }
    return AllButtons;
  }
}
