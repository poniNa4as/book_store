import 'package:book_store/app/utilites/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PutToFirebase {
  static final _firebase = FirebaseFirestore.instance;

  static Future<void> putNewBook(Book book) async {
    try {
      final collection = _firebase.collection('books');

      final dokRef = collection.doc();

      final batch = _firebase.batch();

      final bookWithId = {
        ...book.toJson(), 
        'id': dokRef.id,  
      };

      batch.set(dokRef, bookWithId);

      await batch.commit();
      print("Book successfully added to Firestore!");
    } catch (e) {
      print("Error adding book: $e");
    }
  }
}
