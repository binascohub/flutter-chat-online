import 'package:chat_online/chat_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_online/chat_screen.dart';

void main() async {
  runApp(MyApp());
  /*
  await Firebase.initializeApp();
  FirebaseFirestore.instance.collection("mensagens").doc().set({
    "texto":"Tudo bem?",
    "from":"Joao",
    "read":false
  });

   */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.blue
        )
      ),
      home: ChatScreen(),
    );
  }
}

