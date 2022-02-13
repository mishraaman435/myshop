import 'package:animated_splash/animated_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myshop/provider/MyProvider.dart';
import 'package:myshop/screens/login.dart';
import 'package:myshop/screens/skip_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplash(
      imagePath: 'images/logo.gif',
      home: MyApp(),
      duration: 6000,
      type: AnimatedSplashType.StaticDuration,
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (ctx) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            actionTextColor: Colors.white,
            backgroundColor: Colors.deepPurpleAccent,
          ),
          primaryColor: Colors.deepPurpleAccent,
          accentColor: Color(0xff04d4ee),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SkipScreen();
            } else {
              return Login();
            }
          },
        ),
        // home: ProfileScreen(),
      ),
    );
  }
}
