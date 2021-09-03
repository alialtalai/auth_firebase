import 'package:auth_firebase/Auth/Auth.dart';
import 'package:auth_firebase/UI/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:headup_loading/headup_loading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Register.dart';


class Login extends StatelessWidget {

  var email = TextEditingController();
  var password = TextEditingController();
  var forgot = TextEditingController();
  Auth _auth = new Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
            ),
            ElevatedButton(
                onPressed: ()async{
                 final userId= await _auth.signInWithEmailAndPassword(context,email.text.trim(), password.text.trim()).then((value) => value);

                 if(userId!=null)
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                },
                child: Text('Login')
            ),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                },
                child: Text('Register')
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Text('Reset Password!'),
                onPressed: (){
                  Alert(
                      context: context,
                      title: "Reset Email",
                      content:  TextField(
                        controller: forgot,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () async {
                            var auth = Auth();
                            if (forgot.text.isNotEmpty) {
                              Navigator.pop(context);
                              await auth.resetPassword(context,forgot.text.trim());
                            }
                          },
                          color: Colors.deepOrange,
                          child: Text(
                            "Send",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
