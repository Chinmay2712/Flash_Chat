import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'chat_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final _auth = FirebaseAuth.instance;
  bool showCursor = true;


  @override
  void initState() {
    super.initState();


    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        showCursor = !showCursor;
      });
    });

    // _auth.currentUser != null ? Navigator.push(context, MaterialPageRoute(builder: (context){
    //   return ChatScreen();
    // })) : Navigator.push(context, MaterialPageRoute(builder: (context){
    //   return LoginScreen();
    // }));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Hero(
                  //   tag: 'logo',
                  //   child: Container(
                  //     child: Image.asset('images/logo.png'),
                  //     height: 60,
                  //   ),
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Flash Chat',
                        speed: Duration(milliseconds: 100), // Adjust speed
                        textStyle: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade600,
                        ),
                      ),
                    ],
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                  ),
                  Hero(
                    tag: 'logo',
                    child: AnimatedOpacity(
                      opacity: showCursor ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        "⚡",
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              buttonTitle: 'Log In',
              onPress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              buttonTitle: 'Register',
              onPress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

