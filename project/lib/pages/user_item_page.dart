import 'package:flutter/material.dart';
import '../classes/user_profile_class.dart';
import 'user_profile_page.dart';

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
      languages: ['English', 'German'],
      friends: ['Alice', 'Bob', 'Charlie'],
      imageUrl: 'assets/user.webp',
      role: 'Student',
    ),
    UserProfile(
      userId: '124',
      name: 'Jane Smith',
      address: '456 Elm St, Town',
      description: 'I love learning new languages.',
      languages: ['Spanish', 'Italian'],
      friends: ['David', 'Eve'],
      imageUrl: 'assets/user.webp',
      role: 'Teacher',
    ),
    // Add more users for diversity
    UserProfile(
      userId: '125',
      name: 'Alice Johnson',
      address: '789 Maple St, Village',
      description: 'Passionate about teaching languages.',
      languages: ['French', 'Japanese'],
      friends: ['Frank', 'Grace'],
      imageUrl: 'assets/user.webp',
      role: 'Teacher',
    ),
    UserProfile(
      userId: '126',
      name: 'Bob Brown',
      address: '101 Pine St, Hamlet',
      description: 'Enjoys learning new cultures.',
      languages: ['Chinese', 'Korean'],
      friends: ['Hank', 'Isabel'],
      imageUrl: 'assets/user.webp',
      role: 'Student',
    ),
    UserProfile(
      userId: '127',
      name: 'Charlie Davis',
      address: '202 Cedar St, City',
      description: 'Language hobbyist.',
      languages: ['Russian', 'Persian'],
      friends: ['Jack', 'Karen'],
      imageUrl: 'assets/user.webp',
      role: 'Student',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
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
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(user.imageUrl),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Languages: ${user.languages.join(', ')}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          user.role,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

