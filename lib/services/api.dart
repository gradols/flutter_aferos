import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: prefer_const_constructors
final secureStorage = FlutterSecureStorage();

Future<bool> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://aferosapp-1-d9632560.deta.app/token'),
    headers: {
      //TODO {'Authorization': 'Bearer $token'}
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'password',
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String accessToken = data['access_token'];

    // Guardar el token de acceso en el almacenamiento seguro
    await secureStorage.write(key: 'access_token', value: accessToken);

    return true;
  } else {
    return false;
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);

  return authResult;
}

Future<List<Map<String, dynamic>>> fetchUsers(String accessToken) async {
  debugPrint('Fetching users...');
  final response = await http.get(
    Uri.parse('https://aferosapp-1-d9632560.deta.app/get_all_users?skip=0&limit=10'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((user) => {
      "username": user['username'] ?? '',
      "email": user['email'] ?? '',
      "full_name": user['full_name'] ?? '',
      "age": user['age'] ?? -1,
    }).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
