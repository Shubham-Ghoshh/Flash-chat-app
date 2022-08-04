import 'package:flutter/material.dart';
import 'package:flash/screens/login_screen.dart';
import 'package:flash/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash/components/Buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  double heightAnimation = 0;
  Color bgAnimationColor = Colors.white;
  @override
  void initState() {
    super.initState();
    AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    Animation animation =
        ColorTween(begin: Colors.white, end: Colors.blueAccent)
            .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
      heightAnimation = controller.value;
      bgAnimationColor = animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgAnimationColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Center(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 10),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Flash',
                            colors: [
                              Colors.black54,
                              Colors.yellowAccent,
                            ],
                            textStyle: const TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black54,
                              fontFamily: "Spartan MB",
                            ),
                            speed: const Duration(milliseconds: 60),
                          ),
                        ],
                      )),
                ),
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: heightAnimation * 75,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SignInButton(
                LoginScreen.id,
                "Log In",
                Colors.lightBlueAccent,
                Colors.black54,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SignInButton(
                RegistrationScreen.id,
                "Register",
                Colors.black54,
                Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
