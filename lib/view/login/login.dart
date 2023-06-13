
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviesapp/view/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {




  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(
                    width: 130,
                    child: Icon(Icons.face)),
                  SizedBox(
                    width: 130,
                    child: Text("FaceBook", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300,),))
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () { 
              signInWithGoogle();
              var siuser = FirebaseAuth.instance.currentUser;
              if(siuser != null) {
                Get.to(()=> const HomeScreen());
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(
                    width: 130,
                    child: Icon(Icons.face)),
                  SizedBox(
                    width: 130,
                    child: Text("Google", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),))
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}