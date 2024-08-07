import 'package:flutter/material.dart';
import 'package:loadmore_demo/ui/home/home_page.dart';

class Routers {
  static const String home = '/home';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String? name = settings.name;
    switch (name) {
      case home:
        return animRoute(const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Page not found',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
    }
  }

  static Route animRoute(Widget page, {Offset? beginOffset}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? const Offset(0.0, 0.0);
        var end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
