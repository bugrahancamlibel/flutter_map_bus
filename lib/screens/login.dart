import 'package:flutter/material.dart';
import 'package:flutter_map_bus/widgets/login_components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/login_background.dart';


class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Background(
      child: LoginComponents(),
    );
  }
}
