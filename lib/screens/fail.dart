import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../models/user_model.dart';

class AuthFailScreen extends ConsumerWidget {
  const AuthFailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: auth == null ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(auth == null ? "Username and password are not matching" : auth.name),
            ElevatedButton(
              child: const Text("Go Back"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ):
      Center(
        child: Container(
          width: 400,
          height: 400,
          color: Colors.indigo,
          child: Center(child: Text("Welcome ${auth.name}!")),
        ),
      ),
    );
  }
}
