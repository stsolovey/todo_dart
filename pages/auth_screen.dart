import 'package:flutter/material.dart';
//import 'package:postduo_one/domain/modified_user.dart';
import 'package:flutter_todo/services/auth_service.dart';
//import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';

//import 'package:flutter/foundation.dart'; // debugPrint('movieTitle: $movieTitle');

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget logo(){
      return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            child: const Align(
              child: Text(
                'LoginForm',
                style: TextStyle(fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          )
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon,
              ),
            ),
          ),
        ),

      );
    }

    Widget _button(String text, void func()){
      return ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          func();
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Theme.of(context).primaryColor,
            //onSurface: Colors.green,
            //shadowColor: Colors.yellow,
            elevation: 15,
            side: const BorderSide(color: Colors.black, width: 0.1, style: BorderStyle.solid),
            textStyle: const TextStyle(
              //fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      );
    }

    Widget _form(String label, void func()){
      return Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: _input(const Icon(Icons.email), 'EMAIL', _emailController, false)
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _input(const Icon(Icons.lock), 'PASSWORD', _passwordController, true)
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: _button(label, func)
              ),
            )
          ]
      );
    }

    Future<void> _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.LoginWithEmailAndPassword(_email.trim(), _password.trim());

      if(user == null){
        print('user.Login == null');
        /*Fluttertoast.showToast(
            msg: "Can't Sign you In! Please check your email/password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 25.0
        );*/
      }else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Future<void> _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      User? user = await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());
      if(user == null){
        print('user.register == null');
        /*Fluttertoast.showToast(
            msg: "Unable to Register you! Please check your email/password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );*/
      }else {
        _emailController.clear();
        _passwordController.clear();
      }
    }


    return Scaffold(
        //appBar: AppBar(title: Text('LoginPage'),),
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
            children: <Widget>[
              logo(),
              (
                  showLogin
                      ? Column(
                      children: <Widget>[
                        _form('LOGIN', _loginButtonAction),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                                child: const Text('Not registered yet? Register!', style: TextStyle(fontSize: 20, color: Colors.white)),
                                onTap:() {
                                  setState((){
                                    showLogin = false;
                                  });
                                }
                            )
                        )
                      ]
                  )
                      : Column(
                      children: <Widget>[
                        _form('REGISTER', _registerButtonAction),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                                child: const Text('Already registered? Login!', style: TextStyle(fontSize: 20, color: Colors.white)),
                                onTap:() {
                                  setState((){
                                    showLogin = true;
                                  });
                                }
                            )
                        )
                      ]
                  )
              ),
            ]
        )
    );
    //HomePage();
  }
}
