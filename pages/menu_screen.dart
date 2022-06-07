import 'package:flutter/material.dart';
import 'package:flutter_todo/services/auth_service.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Меню'),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Наше простое меню'),
            Padding(padding: EdgeInsets.only(top: 15)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: Text('На главную')
            ),
            ElevatedButton(
              onPressed: () {
                AuthService().logOut();
              },
              child: Text('LogOut'),
            ),
          ]
      ),
    );
  }
}
