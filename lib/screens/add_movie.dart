import 'package:flutter/material.dart';
import 'package:untitled/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMoviePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addMovieToFirestore(
                  titleController.text,
                  authorController.text,
                  int.tryParse(yearController.text) ?? 0,
                );
                Navigator.pop(context); // Vuelve a la pantalla de lista después de agregar
              },
              child: Text('Add Movie'),
            ),
          ],
        ),
      ),
    );
  }

  void _addMovieToFirestore(String title, String author, int year) async {
    try {
      await FirebaseFirestore.instance.collection('movies').add({
        'title': title,
        'author': author,
        'year': year,
      });
    } catch (e) {
      print('Error adding movie: $e');
    }
  }
}
