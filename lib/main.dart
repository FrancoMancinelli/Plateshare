import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plateshare/firebase_options.dart';
import 'package:plateshare/screens/SplashScreen.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}


