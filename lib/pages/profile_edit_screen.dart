import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/services/profile_service.dart';
import 'package:fooderapp/utils/upload_images.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ProfileEditScreen extends StatefulWidget {
  final User profile;
  const ProfileEditScreen({required this.profile, super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late User _profile;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _profile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change user profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderImagePicker(
                initialValue: [_profile.imageUrl ?? defaultProfileImageUrl],
                name: 'imageUrl',
                decoration: const InputDecoration(labelText: 'Pick Photos'),
                maxImages: 1,
              ),
              FormBuilderTextField(
                name: 'name',
                initialValue: _profile.name,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'bio',
                initialValue: _profile.bio,
                decoration: const InputDecoration(labelText: 'Bio'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final formData = _formKey.currentState!.value;
                    final imageUrls = await uploadImages(formData['imageUrl']);
                    await updateProfile(
                        {...formData, "imageUrl": imageUrls[0]});
                    //ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);
                  }
                },
                child: const Text('Save changes'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
