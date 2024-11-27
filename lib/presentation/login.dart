import 'package:bus_safety/presentation/Registration.dart';
import 'package:bus_safety/services/loginpageapi.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/buss.jpg', // Replace with your actual asset path
              fit: BoxFit.cover,
            ),
          ),
          
          // Centered Column with TextFormFields and Sign Up link
          Center(
            child: SingleChildScrollView(  // Ensures scroll when keyboard appears
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  // Remove the fixed height here
                  color: Color.fromRGBO(128, 128, 128, 0.7),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,  // Makes column take up only necessary space
                    children: [
                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),  // Space between fields
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,  // To obscure password text
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),  // Space between fields and Sign Up link
                      // Login Button
                      ElevatedButton(
                        onPressed: () async {
                          // Validate inputs before login
                          if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill in all fields')),
                            );
                            return;
                          }
                  
                          // Attempt login
                          await loginapi(_usernameController.text, _passwordController.text, context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 5),
                      // Sign Up Link
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationForm(),
                            ),
                          );
                        },
                        child: Text('New user? Sign Up', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 10),
                      // Forgot Password Link
                      TextButton(
                        onPressed: () {
                          // Implement forgot password functionality
                        },
                        child: Text('Forgot password?', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
