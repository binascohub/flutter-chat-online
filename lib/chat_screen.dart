import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_online/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final db = FirebaseFirestore.instance;

  Invocation? get invocation => null;


  void _sendMessage({String? text, XFile? imgXFile}) async {
    Map<String, dynamic> data = {};

    await Firebase.initializeApp();

    if (imgXFile != null) {
      File imgFile = File(imgXFile.path);
      String _timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        await FirebaseStorage.instance
            .ref("uploads/$_timestamp.png")
            .putFile(imgFile);
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        return;
      }

      String url = await FirebaseStorage.instance
          .ref("uploads/$_timestamp.png")
          .getDownloadURL();
      data['imgUrl'] = url;
      print(url);
    }

    if (text != null) {
      data['text'] = text;
    }

    db.collection('messages').doc().set(data);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Ola"),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection('messages').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                   List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text('text'),
                        );
                      },
                    );
                },
              )
            ),
            TextComposer(_sendMessage),
          ],
        ));
  }
}
