import 'package:flutter/material.dart';
import 'package:untitled/screens/add_movie.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart';


class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut(); // Cerrar sesión antes de salir
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie List'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMoviePage()),
                );
              },
            )
          ],
        ),
        body: MovieListView(),
      ),
    );
  }
}


class MovieListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Container(); // Widget en blanco cuando no hay datos
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot<Map<String, dynamic>>? movie = snapshot.data?.docs[index];
            return ListTile(
              title: Text(movie?['title']),
              subtitle: Text('${movie?['author']} - ${movie?['year']}'),
            );
          },
        );
      },
    );
  }
}
