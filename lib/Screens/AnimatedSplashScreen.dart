import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_api_integration/Screens/SearchScreen.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  bool _hasBeenPressed = false;
  int _state = 0;

  bool isLoggedIn = false;

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  void initState() {
    super.initState();

    super.initState();
    setState(() {
      _visible = !_visible;
    });
    //startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,

      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // image: DecorationImage(
            //   image: AssetImage("assets/img.png"),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Align(
            alignment: FractionalOffset.center,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen()));
              },
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                           Colors.black54,
                           Colors.black,
                           Colors.black54,
                        ],
                        begin: FractionalOffset.bottomRight,
                        end: FractionalOffset.bottomRight,
                      ),
                      // border: Border.all(color: white),
                      // color: const Color(0xFFff5800)
                      // borderRadius:
                      //     BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text(
                        "GET START",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
