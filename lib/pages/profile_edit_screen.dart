import 'package:flutter/material.dart';
import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/services/profile_service.dart';

class ProfileEditScreen extends StatefulWidget {
  final User profile;
  const ProfileEditScreen({required this.profile, super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late User _profile;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profile = widget.profile;
    _nameController.text = _profile.name;
    _bioController.text = _profile.bio ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change user profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                // initialValue: _profile.name,
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, process the data
                    String name = _nameController.text;
                    String bio = _bioController.text;

                    await updateProfile({"name": name, "bio": bio});

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
