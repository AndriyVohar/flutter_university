import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/database_service.dart';
import 'edit_screen.dart';

class ViewScreen extends StatelessWidget {
  final String bookId;
  final Book book;

  const ViewScreen({super.key, required this.bookId, required this.book});

  Future<void> _deleteBook(BuildContext context) async {
    try {
      await DatabaseService().deleteBook(bookId);
      Navigator.pop(context); // Go back to the previous screen after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete book: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${book.title}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Authors: ${book.authors.join(', ')}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Publisher: ${book.publisher}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Publication Year: ${book.publicationYear}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Library Section: ${book.librarySection}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Origin: ${book.origin}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Available: ${book.isAvailable ? "Yes" : "No"}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditScreen(bookId: bookId, book: book),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _deleteBook(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
