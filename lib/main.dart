import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviesapp/view/home_page.dart';
import 'package:moviesapp/view/login/login.dart';

import 'controller/Themes/theme_data.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


bool ?issign;

void main() async{
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var siuser = FirebaseAuth.instance.currentUser;
  if(siuser == null) {
    issign = false;
  }else {
    issign = true;
  }
  runApp(
    GetMaterialApp(
      home: const MyApp(),
      title: "Myapp",
      theme: Themes.custumDark,
    ),
    
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const HomeScreen();
    return issign == true ? const HomeScreen() : const Login();
  }
}