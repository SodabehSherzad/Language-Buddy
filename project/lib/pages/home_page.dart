import 'package:flutter/material.dart';
import '../classes/user_profile_class.dart';
import 'favorite_page.dart';
import 'item_page.dart';
import 'my_profile_page.dart';
import 'register_page.dart';
import 'translation_page.dart';
import 'user_item_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    TranslatePage(),
    ProfilePage(userProfile: UserProfile(
      userId: '123',
      name: 'John Doe',
      address: '123 Main St, City',
      description: 'I am a language enthusiast.',
      languages: ['English', 'German', 'French'],
      friends: ['Alice', 'Bob', 'Charlie'],
      imageUrl: '../assets/user.webp',
      role: "Teacher"
    )),
    UserListPage(),
    RegistrationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF), // Light grey background color
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xFF1976D2), // Primary blue color
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1976D2), // Primary blue color
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Random Vocabulary'),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('Term Expansion'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('Favorite Page'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage(),));
              },
            ),
            ListTile(
              title: Text('Language Selection'),
              subtitle: Text('Select Languages'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Register',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.blue,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> themes = [
    {'title': 'Theme 1', 'icon': Icons.language, 'color': Colors.red},
    {'title': 'Theme 2', 'icon': Icons.school, 'color': Colors.green},
    {'title': 'Theme 3', 'icon': Icons.travel_explore, 'color': Colors.blue},
    {'title': 'Theme 4', 'icon': Icons.music_note, 'color': Colors.orange},
    {'title': 'Theme 5', 'icon': Icons.sports, 'color': Colors.purple},
    {'title': 'Theme 6', 'icon': Icons.movie, 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: themes.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage()))
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: themes[index]['color'],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  themes[index]['icon'],
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  themes[index]['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arial', // Font family Arial
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
