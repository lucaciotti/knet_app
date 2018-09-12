import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {

  Animation<double> _logoAnimation;
  AnimationController _logoAnimationController;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = new AnimationController(duration: new Duration(seconds: 5), vsync: this);
    _logoAnimation = new CurvedAnimation(parent: _logoAnimationController, curve: Curves.elasticOut );
    _logoAnimation.addListener(() => this.setState(() {}));
    _logoAnimationController.forward();
    startTimeout();
  }

  void updateWidget(){
    _logoAnimationController.reset();
    _logoAnimationController.forward();
  }

  startTimeout() {
    const timeout = const Duration(seconds: 5);
    return new Timer(timeout, handleTimeout);
  }

  void handleTimeout() {  // callback function
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed('/login'),//print('Next Page'),
        onDoubleTap: () => updateWidget(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* new Transform.rotate(
              angle: _logoAnimation.value * 2 * pi,
              child: new Transform.scale(
                scale: _logoAnimation.value,
                child: new Image.asset(
                  'assets/images/logo.png',
                  width: 150.0,
                ),
              ),
            ), */
            new Transform.scale(
              scale: _logoAnimation.value,
              child: new Image.asset(
                'assets/images/logo.png',
                width: 150.0,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 20.0),
              child: new Text(
                'kNet App',
                style: TextStyle(fontSize: _logoAnimation.value * 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 10.0),
              child: new Text(
                'Krona Koblenz',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




  /* new Container(
    width: 180.0,
    padding: EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
      color: Colors.white
    ),
    child: new Image.asset(
      'images/logo.png',
      width: 150.0,
    ),
  ), */