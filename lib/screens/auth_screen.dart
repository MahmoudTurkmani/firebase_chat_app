import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      bool isLogin, File userImage) async {
    AuthResult authData;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authData = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authData = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final userInfo = await _auth.currentUser();
        final ref = FirebaseStorage.instance
            .ref()
            .child('user-images')
            .child('${userInfo.uid}.jpg');

        await ref.putFile(userImage).onComplete;
        final userImageLink = await ref.getDownloadURL();

        Firestore.instance
            .collection('user')
            .document(authData.user.uid)
            .setData({
          'email': email,
          'username': username,
          'userimage': userImageLink,
        });
      }
    } on PlatformException catch (err) {
      var message = 'Couldn\'t perform this action. Please try again';
      if (err.message != null) {
        message = err.message;
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isLoading),
    );
  }
}
