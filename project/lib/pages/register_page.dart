import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _pageController = PageController();
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  void _nextPage() {
    if (_formKeyStep1.currentState!.validate()) {
      _formKeyStep1.currentState!.save();
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Registeration"),
      // ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue, // Primary blue color
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
                  fontFamily: 'Arial', // Font family Arial
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
                        fontFamily: 'Arial', // Font family Arial
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 100,
                      color: Color(0xFF1976D2), // Primary blue color
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                // color: Color(0xFFD0E1FF), // Light blue color
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD0E1FF), // Primary blue color
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Create Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please create a password';
                        }
                        return null;
                      },
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        child: Text('Next'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1976D2), // Button color same as header
                          textStyle: TextStyle(
                            fontFamily: 'Arial', // Font family Arial
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
                            style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                            },
                            child: Text(
                              'Login now!',
                              style: TextStyle(
                                color: Color(0xFF1976D2), // Primary blue color
                                fontFamily: 'Arial', // Font family Arial
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
                        fontFamily: 'Arial', // Font family Arial
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 120,
                      color: Color(0xFF1976D2), // Primary blue color
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                // color: Color(0xFFD0E1FF), // Light blue color
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD0E1FF), // Primary blue color
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'My Language(s)'),
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Language(s) I want to learn'),
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'My Location'),
                      style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Teacher',
                          style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool value) {},
                        ),
                        Text(
                          'Student',
                          style: TextStyle(fontFamily: 'Arial'), // Font family Arial
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle registration
                        },
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF1976D2), // Button color same as header
                          textStyle: TextStyle(
                            fontFamily: 'Arial', // Font family Arial
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
