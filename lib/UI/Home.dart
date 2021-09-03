import 'package:auth_firebase/Auth/Auth.dart';
import 'package:flutter/material.dart';
import 'package:headup_loading/headup_loading.dart';

import 'Login.dart';

class Home extends StatelessWidget {
  Auth _auth = new Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            HeadUpLoading.show(context);
            await _auth.signOut();
            HeadUpLoading.hide();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
          })
        ],
      ),
      body:Container(
        alignment: Alignment.center,
        child: Text('UserId: ${_auth.currentUser()}'),
      ) ,
    );
  }
}
