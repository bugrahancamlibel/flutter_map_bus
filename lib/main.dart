import 'package:flutter/material.dart';
import 'package:flutter_map_bus/screens/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset : false,
        body: const Login(),
        appBar: AppBar(title: const Text("KOU BUS")),
      ),
    );
  }
}
