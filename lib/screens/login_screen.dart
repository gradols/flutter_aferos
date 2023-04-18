import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/services/api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                bool success = await login(_usernameController.text, _passwordController.text);
                if (mounted) {
                  if (success) {
                    _navigateToHome(context);
                  } else {
                    _showLoginFailedSnackBar(context);
                  }
                }
              },
            ),
            const SizedBox(height: 10),
            _signInButton(),
          ],
        ),
      ),
    );
  }

void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _showLoginFailedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login failed. Please try again.')),
    );
  }

  Widget _signInButton() {
  return 
    ElevatedButton.icon(
      onPressed: () async {
        try {
          UserCredential userCredential = await signInWithGoogle();
          if (userCredential.user != null && mounted) {
            _navigateToHome(context);
          }
        } catch (error) {
          if (mounted) {
            _showLoginFailedSnackBar(context);
          }
        }
      },
      icon: const Icon(Icons.login),
      label: const Text('Iniciar sesión con Google'),
    );
  }
}

