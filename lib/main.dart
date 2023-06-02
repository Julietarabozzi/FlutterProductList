import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_json/viewmodels/login_viewmodel.dart';
import 'package:prueba_json/viewmodels/product_viewmodel.dart';
import 'package:prueba_json/views/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
