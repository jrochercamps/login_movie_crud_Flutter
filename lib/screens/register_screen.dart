import 'package:flutter/material.dart';
import 'package:untitled/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/screens/movie_list.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Registrar nuevo usuario con email y contraseña
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  print('Nuevo usuario registrado: ${userCredential.user!.uid}');

                  // Navegar a la Segunda Pantalla después del registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieList()),
                  );
                } on FirebaseAuthException catch (e) {
                  print('Error de registro: $e');
                  // Manejar errores de registro, por ejemplo, mostrar un mensaje al usuario
                }
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}