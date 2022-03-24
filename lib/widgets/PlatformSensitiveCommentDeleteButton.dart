import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/widgets/PlatformSensitiveWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlatformSensitiveCommentDeleteButton extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final String mainButtonText;
  final String secondaryButtonText;
  final Chat chat;
  final String OwnerID;
  VoidCallback callback;

  PlatformSensitiveCommentDeleteButton(
      {required this.title,
      required this.chat,
      required this.OwnerID,
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
        onPressed: () async {
          // var docs = await FirebaseFirestore.instance
          //     .collection("comments")
          //     .where(
          //       "Content",
          //       isEqualTo: content,
          //     )
          //     .get();
          // for (var docs1 in docs.docs) {
          //   if (docs1["OwnerID"].toString() == OwnerID) {
          //     await FirebaseFirestore.instance
          //         .runTransaction((transaction) async {
          //       await transaction.delete(docs1["Content"]);
          //     });
          //   }
          // }

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
          onPressed: () async {
            // var docs = await FirebaseFirestore.instance
            //     .collection("comments")
            //     .where(
            //       "Content",
            //       isEqualTo: content,
            //     )
            //     .get();
            // for (var docs1 in docs.docs) {
            //   if (docs1["OwnerID"].toString() == OwnerID) {
            //     await FirebaseFirestore.instance
            //         .runTransaction((transaction) async {
            //       await transaction.delete(docs1["Content"]);
            //     });
            //   }
            // }
            callback();
            Navigator.pop(context);
          },
          child: Text(mainButtonText)));
    }
    return AllButtons;
  }
}
