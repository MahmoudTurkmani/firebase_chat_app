import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMessage extends StatefulWidget {
  @override
  _AddMessageState createState() => _AddMessageState();
}

class _AddMessageState extends State<AddMessage> {
  final _messageController = TextEditingController();
  var _message = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _messageController.clear();
    final user = await FirebaseAuth.instance.currentUser();
    final userInfo =
        await Firestore.instance.collection('user').document(user.uid).get();

    Firestore.instance.collection('chats').add({
      'text': _message,
      'createdAt': Timestamp.now(),
      'userid': user.uid,
      'username': userInfo['username'],
      'userimage': userInfo['userimage'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter a message...',
              ),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _message.isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
