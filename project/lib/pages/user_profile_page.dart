import 'package:flutter/material.dart';
import '../models/user.dart';
import 'chat_page.dart';

class UserProfilePage extends StatelessWidget {
  final UserProfile userProfile;

  const UserProfilePage({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(userProfile.imageUrl),
                radius: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              userProfile.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Role: ${userProfile.role}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              'Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userProfile.address,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userProfile.description,
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
              children: userProfile.languages
                  .map((language) => Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(language, style: TextStyle(fontSize: 16)),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Follow/Unfollow logic here
                    // You can implement your follow/unfollow functionality here
                  },
                  child: Text('Follow/Unfollow'), // Change text based on follow status

            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(), // Direct to ChatPage
                  ),
                );
              },
              child: Text('Chat'),
            ),
          ],
        ),
      ),
    );
  }
}