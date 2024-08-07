import 'package:flutter/material.dart';
import 'package:loadmore_demo/helpers/provider_setup.dart';
import 'package:loadmore_demo/helpers/routers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routers.generateRoute,
      initialRoute: Routers.home,
    );
  }
}
