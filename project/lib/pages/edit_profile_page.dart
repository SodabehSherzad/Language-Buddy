import 'package:flutter/material.dart';

import '../classes/user_profile_class.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfilePage({required this.userProfile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _addressController = TextEditingController(text: widget.userProfile.address);
    _descriptionController = TextEditingController(text: widget.userProfile.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save changes and pop the page
                  _saveChanges();
                },
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    // Save changes to userProfile object
    widget.userProfile.updateProfile(
      newName: _nameController.text,
      newAddress: _addressController.text,
      newDescription: _descriptionController.text,
    );

    // Navigate back to profile page and return the updated userProfile
    Navigator.pop(context, widget.userProfile); // Pass the updated userProfile object
  }


}
