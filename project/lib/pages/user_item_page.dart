import 'package:flutter/material.dart';

import '../classes/user_profile_class.dart';
import 'chat_page.dart';
import 'user_profile_page.dart';

// Assuming UserProfile and other imports are already included here

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final List<UserProfile> users = [
    UserProfile(
      userId: '123',
      name: 'John Doe',
      address: '123 Main St, City',
      description: 'I am a language enthusiast.',
      languages: ['English', 'German', 'French'],
      friends: ['Alice', 'Bob', 'Charlie'],
      imageUrl: 'assets/user.webp', // Adjusted the image asset path
    ),
    UserProfile(
      userId: '124',
      name: 'Jane Smith',
      address: '456 Elm St, Town',
      description: 'I love learning new languages.',
      languages: ['Spanish', 'Italian'],
      friends: ['David', 'Eve'],
      imageUrl: 'assets/user.webp', // Adjusted the image asset path
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users
        .where((user) =>
        user.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return UserItem(user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  final UserProfile user;

  UserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfilePage(userProfile: user),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(user.imageUrl),
              ),
              SizedBox(height: 8),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Languages: ${user.languages.join(', ')}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
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
      ),
    );
  }
}

// UserProfilePage and ChatPage are assumed to be defined elsewhere in your project
