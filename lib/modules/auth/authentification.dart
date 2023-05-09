// ignore_for_file: avoid_print, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../screens/home_page.dart';

class Authentification extends StatefulWidget {
  const Authentification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentification> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  void checkCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        _isAuthenticated = true;
        _email = currentUser.email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAuthenticated
          ? const HomePage()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'L\' email est obligatoire';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _password = value;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Le mot de passe est obligatoire';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            // ignore: unused_local_variable
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );
                            setState(() {
                              _isAuthenticated = true;
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              Fluttertoast.showToast(
                                  msg:
                                      "Aucun utilisateur trouvé avec cet addresse email",
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16);
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              Fluttertoast.showToast(
                                  msg: "Email ou Mot de passe incorrect",
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16);
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            // ignore: unused_local_variable
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );
                            await db
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'email': _email,
                              'display_name': "",
                              'phone_number': "",
                              'photo_url': "",
                            });
                            setState(() {
                              _isAuthenticated = true;
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              Fluttertoast.showToast(
                                  msg: "Mot de passe trop petit",
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16);
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for '
                                  'that email.');
                              Fluttertoast.showToast(
                                  msg: "Un compte avec cet email existe déjà",
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 16);
                            }
                          } catch (e) {
                            print(e);
                            Fluttertoast.showToast(
                                msg: "Une erreur s'est produite, réessayer",
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16);
                          }
                        }
                      },
                      child: const Text('S\'inscrire'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
