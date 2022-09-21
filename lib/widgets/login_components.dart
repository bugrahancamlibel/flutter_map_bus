import 'package:flutter/material.dart';
import 'package:flutter_map_bus/models/user_model.dart';
import 'package:flutter_map_bus/screens/admin.dart';
import 'package:flutter_map_bus/screens/town_select.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var nickController = TextEditingController();
var passwordController = TextEditingController();

class LoginComponents extends ConsumerWidget {
  const LoginComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    final auth = ref.read(authProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Text(
            "LOGIN",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2661FA),
                fontSize: 36),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            controller: nickController,
            decoration: const InputDecoration(labelText: "Username"),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            //validator: (value) => passwordController.text.isEmpty ? "Can't be empty" : null,
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        ),
        SizedBox(height: size.height * 0.05),
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: ElevatedButton(
            onPressed: () {
              //auth.setCurrentUser(User(id: 23, name: nickController.text, password: passwordController.text));
              print("kull ad: ${nickController.text}");
              print("şifre: ${passwordController.text}");
              auth.getLogin(nickController.text, passwordController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TownSelectScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: const EdgeInsets.all(0),
              textStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 255, 136, 34),
                    Color.fromARGB(255, 255, 177, 41)
                  ])),
              padding: const EdgeInsets.all(0),
              child: const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
            );
          },
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 40),
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent])),
              padding: const EdgeInsets.all(0),
              child: const Text(
                "ADMIN PANEL",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
