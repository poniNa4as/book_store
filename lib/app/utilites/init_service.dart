import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_store/app/utilites/books.dart';

class InitService {
  static final _firebase = FirebaseFirestore.instance;

  static Future<void> loadData() async {
    final collection = _firebase.collection('books');
    final snapshot = await collection.get();

    if (snapshot.docs.isEmpty) {
      final batch = _firebase.batch();
      for (final book in books) {
        final docRef = collection.doc();
        final bookWithId = {
          ...book.toJson(),
          'id': docRef.id,
        };
        batch.set(docRef, bookWithId);
      }
      await batch.commit();
    } 
  }
}
