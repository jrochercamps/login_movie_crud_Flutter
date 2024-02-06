import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/screens/movie_list.dart';
import 'package:untitled/screens/add_movie.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  // Iniciar sesión con email y contraseña
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  print('Usuario autenticado: ${userCredential.user!.uid}');

                  // Navegar a la pantalla de lista de películas
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieList()),
                  );
                } on FirebaseAuthException catch (e) {
                  print('Error de inicio de sesión: $e');
                  // Manejar errores de inicio de sesión, por ejemplo, mostrar un mensaje al usuario
                }
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMoviePage()),
                );
              },
              child: Text('Crear una cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
