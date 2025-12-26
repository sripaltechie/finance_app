import 'package:flutter/material.dart';
import 'package:chanda_finance/view_model/services/splash_services.dart';

import '../utils/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    //TODO: implement initState
    super.initState();

    splashServices.checkAuthentication(context);
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1500));

    // _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // _animationController.forward();
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 2000));
    // animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Text('Chanda \nFinance',
              style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
    );
    // Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/bg1.jpg'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Center(
    //     child: AnimatedOpacity(
    //       opacity: 1.0,
    //       duration: Duration(seconds: 2),
    //       curve: Curves.easeInOut,
    //       child: Text('Chanda Finance',
    //           style: Theme.of(context).textTheme.headlineLarge
    //           // TextStyle(
    //           //   color: Colors.white,
    //           //   fontSize: 24.0,
    //           //   fontWeight: FontWeight.bold,
    //           // ),
    //           ),
    //     ),
    //   ),
    // );
  }
}


  // Scaffold(
  //   body: FadeTransition(
  //     opacity: _animation,
  //     child: Container(
  //       color: Colors.blue[200],
  //       child: Center(
  //         child: Image.asset('assets/logo.png'),
  //       ),
  //     ),
  //   ),
  // );

  // Scaffold(
  //     body: Container(
  //   color: Colors.blue.shade200,
  //   child: Center(
  //     child: Text(
  //       "CHANDA \nFINANCE",
  //       style: Theme.of(context).textTheme.headlineMedium,
  //     ),
  //   ),
  // ));

// }
