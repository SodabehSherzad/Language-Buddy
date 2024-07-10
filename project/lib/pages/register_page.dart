import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';
import 'dart:math';

import '../models/api_service.dart';
import '../models/user.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _pageController = PageController();
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  String? _username;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _myLanguages;
  String? _languagesToLearn;
  String? _location;
  bool _isTeacher = false;

  final ApiService _apiService = ApiService();

  void _nextPage() {
    if (_formKeyStep1.currentState!.validate()) {
      _formKeyStep1.currentState!.save();
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _register() async {
    if (_formKeyStep2.currentState!.validate()) {
      _formKeyStep2.currentState!.save();

      final user = UserProfile(
        userId: Random().nextInt(10000).toString(),
        name: _username!,
        address: _location!,
        description: '',
        languages: [_myLanguages!],
        friends: [],
        imageUrl: '',
        role: _isTeacher ? 'teacher' : 'student',
      );

      final success = await _apiService.register(user);
      if (success) {
        // Handle successful registration
        print('Registration successful');
      } else {
        // Handle registration failure
        print('Registration failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Text(
                'LANGUAGE BUDDY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildStep1(),
                _buildStep2(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKeyStep1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 100,
                      color: Color(0xFF1976D2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD0E1FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your username';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _username = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter your email';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _email = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Create Password'),
                      obscureText: true,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please create a password';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _password = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please confirm your password';
                      //   }
                        // if (value != _password) {
                        //   return 'Passwords do not match';
                        // }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _confirmPassword = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        child: Text('Next'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1976D2),
                          textStyle: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(fontFamily: 'Arial'),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Login now!',
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKeyStep2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'My Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 120,
                      color: Color(0xFF1976D2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD0E1FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'My Language(s)'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your languages';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _myLanguages = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Language(s) I want to learn'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the languages you want to learn';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _languagesToLearn = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'My Location'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _location = value;
                      },
                      style: TextStyle(fontFamily: 'Arial'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Teacher',
                          style: TextStyle(fontFamily: 'Arial'),
                        ),
                        Switch(
                          value: _isTeacher,
                          onChanged: (bool value) {
                            setState(() {
                              _isTeacher = value;
                            });
                          },
                        ),
                        Text(
                          'Student',
                          style: TextStyle(fontFamily: 'Arial'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _register;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1976D2),
                          textStyle: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}