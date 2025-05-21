import 'package:firebase_database/firebase_database.dart';
import '../models/book.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Add a book to the database
  Future<void> addBook(Book book) async {
    try {
      final newBookRef = _dbRef.child('books').push();
      await newBookRef.set(book.toMap()..['uid'] = newBookRef.key);
    } catch (e) {
      throw Exception('Failed to add book: $e');
    }
  }

  // Fetch all books from the database
  Future<List<Book>> fetchBooks() async {
    try {
      final snapshot = await _dbRef.child('books').get();
      if (snapshot.exists) {
        final books = <Book>[];
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          books.add(Book.fromMap(Map<String, dynamic>.from(value)));
        });
        return books;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }

  // Update a book in the database
  Future<void> updateBook(String bookId, Book book) async {
    try {
      await _dbRef.child('books/$bookId').update(book.toMap());
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  // Delete a book from the database
  Future<void> deleteBook(String bookId) async {
    try {
      await _dbRef.child('books/$bookId').remove();
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }
}
