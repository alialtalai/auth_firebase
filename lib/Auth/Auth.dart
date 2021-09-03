import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:headup_loading/headup_loading.dart';




class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<String> signInWithEmailAndPassword(BuildContext context,String email, String password) async {
    HeadUpLoading.show(context);
    var userId= await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value){
      HeadUpLoading.hide();
      return value.user?.uid;
    }).catchError((error){
      HeadUpLoading.hide();
      print(error.code);
      switch(error.code){
        case 'user-not-found':
          InfoAlertBox(context: context,title: 'User not found!',infoMessage: 'Please register and try again');
          return null;
          break;

        case 'wrong-password':
          InfoAlertBox(context: context,title: 'Wrong password!',infoMessage: 'Reset your password if you forgot');
          return null;
          break;
        case 'invalid-email':
          InfoAlertBox(context: context,title: 'Invalid email!',infoMessage: 'Please enter correct email');
          return null;
          break;
        case 'network-request-failed':
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'Please check your internet and try again!');
          return null;
          break;
        default:
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'some problem happen, please try again!');
          return null;

      }
    }).timeout(Duration(seconds: 15),onTimeout: (){
      HeadUpLoading.hide();
      return null;
    });

    return userId;

  }


  Future<String> createUserWithEmailAndPassword(BuildContext context,String email, String password) async {

    var user ;
    HeadUpLoading.show(context);
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value){

      user = value.user?.uid;
      HeadUpLoading.hide();
    }).catchError((e){
      print(e.code);
      HeadUpLoading.hide();
      switch(e.code){
        case 'weak-password':
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'Please enter a password with 6 digit at least');
          return null;
          break;
        case 'invalid-email':
          InfoAlertBox(context: context,title: 'Invalid email!',infoMessage: 'Please enter correct email');
          return null;
          break;
        case 'email-already-in-use':
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'The email already used!');
          return null;
          break;
        case 'network-request-failed':
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'Please check your internet and try again!');
          return null;
          break;
        default:
          InfoAlertBox(context: context,title: 'Notice!',infoMessage: 'some problem happen, please try again!');
          return null;

      }

    });
    return user;
  }


    currentUser() {
    final User user = _firebaseAuth.currentUser;
    return user?.uid;
  }


  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }


  Future<void> resetPassword(BuildContext context,String email) async {
    HeadUpLoading.show(context);
    await _firebaseAuth.sendPasswordResetEmail(email: email).then((value){
      HeadUpLoading.hide();
      SuccessAlertBox(context: context,title: 'Success',messageText: 'We have send a reset email to $email');
    }).catchError((e){
      HeadUpLoading.hide();
      if(e.code=='user-not-found')
        InfoAlertBox(context: context,title: 'Notice',infoMessage: 'The $email is not registered ');
    }).timeout(Duration(minutes: 1),onTimeout: (){
      HeadUpLoading.hide();
      InfoAlertBox(context: context,title: 'Notice',infoMessage: 'Check your internet and try again');
    }).whenComplete((){
      HeadUpLoading.hide();
    });
  }

}