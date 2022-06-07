import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/pages/menu_screen.dart';
import 'package:flutter_todo/services/auth_service.dart';

class TaskList extends StatefulWidget {

  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();

}

class _TaskListState extends State<TaskList> with SingleTickerProviderStateMixin {

  String _userToDO = '';
  //List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
}

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    //initFirebase();

    _controller = AnimationController(vsync: this);

    //todoList.addAll(['Basics', 'Основы', 'Семья', 'Dating', 'Something else']);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return const MenuScreen();
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu_outlined),
            onPressed: _menuOpen,
          )
        ]
      ),
      body: StreamBuilder(
        //stream: FirebaseFirestore.instance.collection('items').where("userId", isEqualTo: AuthService().getCurrentUser!.uid).snapshots(),
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return const Text('Нет записей', style: TextStyle(color: Colors.white));
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                          title: Text(snapshot.data!.docs[index].get('item')),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_sweep_rounded),
                            onPressed: (){
                              FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                            },
                          )
                      ),
                    ),
                    onDismissed: (direction) {
                      //if(direction == DismissDirection.endToStart) print("endToStart ${todoList[index]}");
                      //if(direction == DismissDirection.startToEnd) print("startToEnd ${todoList[index]}");
                      FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();

                    }
                );
              }
          );
        },
      ),
      /**/
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value) {
                  _userToDO = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  //FirebaseFirestore.instance.collection('item/test').add
                  FirebaseFirestore
                      .instance
                      .collection('users')
                      .doc(AuthService().getCurrentUser!.uid)
                      .collection('useritems').add

                  (
                      {
                        'item': _userToDO,
                        'userId' : AuthService().getCurrentUser!.uid,
                        'serverTimeStamp' : Timestamp.now(),
                      }
                  );
                  Navigator.of(context).pop();
                },child: Text('Добавить'))
              ]
            );
          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      )
    );
  }
}
