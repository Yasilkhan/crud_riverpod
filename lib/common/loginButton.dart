import 'package:crud_riverpod/constant/logos.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/screens/home_page.dart';


class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    // ref.read(authControllerProvider).signInWithGoogle(context);

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body:
        Container(
          height: w * 0.15,
          width: w * 0.5,
          color: Colors.blue,
        ),
    );
  }
}
