import 'package:firebase_messaging/firebase_messaging.dart';
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
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          await auth(await state.user?.getIdToken(), fcmToken!);
          Navigator.pushReplacementNamed(context, homePage);
        }),
      ],
    );
  }
}
