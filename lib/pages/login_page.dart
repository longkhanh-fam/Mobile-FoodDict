import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [EmailAuthProvider()],
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          Navigator.pushReplacementNamed(context, homePage);
          await auth(await state.user?.getIdToken());
        }),
      ],
    );
  }
}
