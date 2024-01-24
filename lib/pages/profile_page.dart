import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/pages/profile_edit_screen.dart';
import 'package:fooderapp/services/profile_service.dart'; // Import your User class

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> _profile = getProfile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: FutureBuilder(
            future: _profile,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator
              } else if (snapshot.hasError) {
                // Handle error state
                return Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseUIAuth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginPage, (Route<dynamic> route) => false);
                        },
                        child: const Text("Sign out")),
                    Text('Error: ${snapshot.error}')
                  ],
                );
              } else {
                User user = snapshot.data;
                // return ProfileScreen(
                //   children: [text],
                //       providers: [EmailAuthProvider()],
                //       actions: [
                //         SignedOutAction((context) {
                //           Navigator.pushReplacementNamed(context, '/sign-in');
                //         }),
                //       ],
                //     );
                return Column(
                  children: <Widget>[
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user.imageUrl ?? defaultProfileImageUrl,
                            height: 150.0,
                            width: 150.0,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name,
                                  style: const TextStyle(fontSize: 20)),
                              Row(
                                children: [
                                  Text("${user.followers} followers"),
                                  const SizedBox(width: 10),
                                  Text("${user.following} following"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(user.bio ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 0, 0),
                          child: OutlinedButton(
                            onPressed: () async {
                              final res = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileEditScreen(profile: user)));
                              if (res == true) {
                                setState(() {
                                  _profile = getProfile();
                                });
                              }
                            },
                            child: const Text('Edit profile'),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseUIAuth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginPage, (Route<dynamic> route) => false);
                        },
                        child: const Text("Sign out")),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
