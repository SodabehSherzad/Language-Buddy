import 'package:flutter/material.dart';
import 'package:project/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF1976D2), // Primary blue color
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial', // Font family Arial
                  ),
                ),
                Container(
                  height: 2,
                  width: 100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Username/Email'),
                            style: TextStyle(
                                fontFamily: 'Arial'), // Font family Arial
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            style: TextStyle(
                                fontFamily: 'Arial'), // Font family Arial
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle login
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xFF1976D2), // Button color same as header
                                textStyle: TextStyle(
                                  fontFamily: 'Arial', // Font family Arial
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage(),));
                              },
                              child: Text(
                                'Don’t have an account? Register now!',
                                style: TextStyle(
                                  color:
                                      Color(0xFF1976D2), // Primary blue color
                                  fontFamily: 'Arial', // Font family Arial
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
          ),
        ],
      ),
    );
  }
}
