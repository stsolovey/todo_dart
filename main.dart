import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/main_screen.dart';
import 'package:flutter_todo/pages/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo/pages/task_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo/services/auth_service.dart';
import 'package:flutter_todo/pages/landing.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const todoApp());
}

class todoApp extends StatelessWidget{
  const todoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<User?>.value(
      value: AuthService().changes,
      initialData: AuthService().getCurrentUser,
      child: MaterialApp(
          theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          textTheme: const TextTheme(subtitle1: TextStyle(color: Colors.black)),
        ),
        initialRoute: '/', // home: const Landing(),
        routes: {
          '/': (context) => Landing(),
          '/todo': (context) => TaskList(),
          '/auth_screen': (context) => AuthorizationPage(),
          '/main_screen' : (context) => MainScreen(),
        },
      )

    );
  }
}
/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.purpleAccent,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purpleAccent,
          ),
        ),


      )
  );
}*/
