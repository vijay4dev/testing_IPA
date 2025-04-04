import 'package:butterflix/dashboard/Screens/dashboard_screen.dart';
import 'package:butterflix/home/home_screen.dart';
import 'package:butterflix/onboarding/screens/login_signup_screen.dart';
import 'package:butterflix/onboarding/screens/onboarding.dart';
import 'package:butterflix/screens_vijay/genre_screen_final.dart';
import 'package:butterflix/screens_vijay/login_screen.dart';
import 'package:butterflix/screens_vijay/otp_screen.dart';
import 'package:butterflix/splash/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case "/":
      //   return MaterialPageRoute(
      //     builder: (context) => const Splash(),
      //   );
      case AppScreen.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case AppScreen.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case AppScreen.dashboard:
        return MaterialPageRoute(
          builder: (context) => DashBoard(),
        );
      case AppScreen.LoginSignupScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginSignupScreen(),
        );

      case AppScreen.OtpVerificationScreen:
        return MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(),
        );

      case AppScreen.LoginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case AppScreen.GenreScreen:
        return MaterialPageRoute(
          builder: (context) => const GenreScreenFinal(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("somthing went wrong"),
        ),
      );
    });
  }
}

class AppScreen {
  static const String onBoardingScreen = "onBoardingScreen";
  static const String splashScreen = "splashScreen";
  static const String LoginSignupScreen = "LoginSignupScreen";
  static const String LoginScreen = "LoginScreen";
  static const String OtpVerificationScreen = "OtpVerificationScreen";
  static const String GenreScreen = "GenreScreenFinal";
  static const String dashboard = "dashboard";
}
