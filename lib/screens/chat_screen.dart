import 'dart:collection';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String loggedInUserEmail = "";

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Text> messageWidgets = [];
  final messageTextEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String message = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUserEmail = (user.email).toString();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          color: Colors.white54,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        foregroundColor: Colors.white70,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.xmark, color: Colors.white54),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Row(
          children: const [
            Text(
              'Hola ',
              style: TextStyle(fontFamily: "Spartan MB", color: Colors.white),
            ),
            Icon(
              FontAwesomeIcons.bolt,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(fireStore: _fireStore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12, 0, 12),
                      child: TextField(
                        cursorColor: Colors.white54,
                        showCursor: true,
                        controller: messageTextEditingController,
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,

                          // fontFamily: "Spartan MB",
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextEditingController.clear();
                      _fireStore.collection("messages").add({
                        "text": message,
                        "sender": loggedInUserEmail,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      size: 26,
                      color: Colors.blueAccent,
                    ),
                    // child: const Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore fireStore,
  })  : _fireStore = fireStore,
        super(key: key);

  final FirebaseFirestore _fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _fireStore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;

          for (var message in messages) {
            final messageData = message.data();
            final messageText = messageData['text'];
            final messageSender = messageData['sender'];
            final currentUser = loggedInUserEmail;
            final messageBubble = MessageBubble(
                messageSender, messageText, currentUser == messageSender);
            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            // padding: EdgeInsetsSymmetric.,
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(this.sender, this.text, this.isMe);
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.indigoAccent,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.black54 : Colors.white70,
                    fontSize: 15,
                    fontFamily: "Spartan MB"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
