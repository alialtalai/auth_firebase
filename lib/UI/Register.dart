import 'package:auth_firebase/Auth/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';


class Register extends StatelessWidget {

  var email = TextEditingController();
  var password = TextEditingController();
  Auth _auth = new Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  var userId=await _auth.createUserWithEmailAndPassword(context,email.text.trim(), password.text.trim()).then((value) => value);
                   if(userId!=null)
                     SuccessAlertBox(context: context,title: 'Success',messageText: 'You have Register Successfully');

                },
                child: Text('Register')
            ),

          ],
        ),
      ),
    );
  }
}
