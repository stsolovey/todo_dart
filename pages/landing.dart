import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/pages/auth_screen.dart';
import 'package:flutter_todo/pages/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    print("userId: ${user?.uid}");
    return user == null ? AuthorizationPage() : MainScreen();
  }
}
