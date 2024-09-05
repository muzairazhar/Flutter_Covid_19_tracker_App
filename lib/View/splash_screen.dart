import 'dart:async';


import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_covid_19_tracker_app/View/wold_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  late final AnimationController _animation=AnimationController(
      duration: Duration(seconds: 3),
      vsync:this,
  )..repeat();
  @override
  void initState() {

    Timer(Duration(seconds: 5),() => Navigator.push(context,MaterialPageRoute(builder: (context) => Worldstatescreen(),)),);
    super.initState();
  }x
  @override
  void dispose() {
    // Dispose the animation controller when the state is disposed
    _animation.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value*2.0*math.pi,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image(image:AssetImage('images/virus.png')),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height:  MediaQuery.of(context).size.height*.08,),
            Align(
              alignment: Alignment.center,
              child: Text("Covid-19\nTracker App",textAlign:TextAlign.center,style: TextStyle(

                fontWeight:FontWeight.bold,
                fontSize:25,

              ),),
            )


          ],
        ),
      ),
    );
  }
}
