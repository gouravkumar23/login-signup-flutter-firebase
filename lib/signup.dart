import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dojController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  void _signup() async {
    User? user = await _authService.signup(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      _dobController.text,
      _addressController.text,
      _dojController.text,
      _roleController.text,
      double.tryParse(_salaryController.text) ?? 0.0,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Successful!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup Failed.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              TextField(controller: _dobController, decoration: InputDecoration(labelText: "Date of Birth")),
              TextField(controller: _addressController, decoration: InputDecoration(labelText: "Address")),
              TextField(controller: _dojController, decoration: InputDecoration(labelText: "Date of Joining")),
              TextField(controller: _roleController, decoration: InputDecoration(labelText: "Role")),
              TextField(controller: _salaryController, decoration: InputDecoration(labelText: "Salary")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signup, child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
