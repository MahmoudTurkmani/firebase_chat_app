import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('chats')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatsSnapshot) {
              if (chatsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final chatsDocuments = chatsSnapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatsDocuments.length,
                  itemBuilder: (ctx, index) {
                    return MessageBubble(
                      chatsDocuments[index]['text'],
                      chatsDocuments[index]['userid'] ==
                          futureSnapshot.data.uid,
                      chatsDocuments[index]['username'],
                      chatsDocuments[index]['userimage'],
                    );
                  },
                );
              }
            },
          );
        });
  }
}
