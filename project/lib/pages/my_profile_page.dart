import 'package:flutter/material.dart';

import '../classes/user_profile_class.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  UserProfile userProfile;

  ProfilePage({required this.userProfile});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.userProfile.imageUrl),
                radius: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.userProfile.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.userProfile.address,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.userProfile.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Languages Known:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.userProfile.languages.map((language) => Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(language, style: TextStyle(fontSize: 16)),
              )).toList(),
            ),
            SizedBox(height: 10),
            Text(
              'My Friends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userProfile.imageUrl),
                    radius: 50,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userProfile.imageUrl),
                    radius: 50,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userProfile.imageUrl),
                    radius: 50,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate to edit profile page and wait for result
                  final updatedProfile = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(userProfile: widget.userProfile),
                    ),
                  );

                  // Update userProfile with the updated profile if not null
                  if (updatedProfile != null) {
                    setState(() {
                      widget.userProfile = updatedProfile;
                    });
                  }
                },
                child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
