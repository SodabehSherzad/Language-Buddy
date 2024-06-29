import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(16.0),
            child: Expanded(child:
            Column(children: [
              TextField(
                decoration: InputDecoration(labelText: 'Username/Email'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle login
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to registration page
                },
                child: Text('Don’t have an account? Register now!'),
              ),
            ],),),),
          ],
        ),
    );
  }
}
