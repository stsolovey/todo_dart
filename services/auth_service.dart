import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo/pages/landing.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter/foundation.dart'; // debugPrint('movieTitle: $movieTitle');



class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User?> LoginWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print('ошибка $e');
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print('ошибка $e');
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
    return const Landing();
  }

  // This is total bull shit (I have spoken, S.Solovej)
  User? get getCurrentUser {
    if (_fAuth.currentUser != null) {
      return _fAuth.currentUser;
    } else {
      return null;
    }
  }

  Stream<User?> get changes {
    return _fAuth.authStateChanges();
  }




}

