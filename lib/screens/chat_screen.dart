import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/messages.dart';
import '../widgets/add_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Chat :)'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).buttonColor,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Text('Log Out'),
                  ],
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          AddMessage(),
        ],
      ),
    );
  }
}
