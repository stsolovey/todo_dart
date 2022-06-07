import 'package:flutter/material.dart';
//import 'package:flutter_todo/pages/task_list.dart';

    class MainScreen extends StatelessWidget {
      const MainScreen({Key? key}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
            title: Text('Главный экран'),
            centerTitle: true,
        ),
        body: Column(
            children: [
              Text('Main Screen', style: TextStyle(color: Colors.white)),
              ElevatedButton(
                  onPressed: (){
                    //Navigator.pushReplacementNamed(context, '/todo');
                 Navigator.pushNamedAndRemoveUntil(context, '/todo', (route)=>false);
                  },
                  child: const Text('К списку дел')),
              /*ElevatedButton(
                onPressed: (){
                  //Navigator.pushReplacementNamed(context, '/auth_screen');
                  Navigator.pushNamedAndRemoveUntil(context, '/auth_screen', (route)=>false);
                },
                child: const Text('===> Auth'),
              )*/
          ]
        )
        );
      }
    }
