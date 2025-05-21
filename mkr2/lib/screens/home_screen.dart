import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> _booksFuture;
  String _filterQuery = '';

  @override
  void initState() {
    super.initState();
    _booksFuture = DatabaseService().fetchBooks();
  }

  void _filterBooks(String query) {
    setState(() {
      _filterQuery = query.toLowerCase();
      _booksFuture = DatabaseService().fetchBooks().then((books) {
        return books.where((book) {
          return book.title.toLowerCase().contains(_filterQuery) ||
              book.librarySection.toLowerCase().contains(_filterQuery);
        }).toList();
      });
    });
  }

  Future<void> _refreshBooks() async {
    setState(() {
      _booksFuture = DatabaseService().fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Library')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Filter by title or section',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterBooks,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshBooks,
              child: FutureBuilder<List<Book>>(
                future: _booksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No books found.'));
                  } else {
                    final books = snapshot.data!;
                    return ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return BookCard(
                          book: book,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/view',
                              arguments: {
                                'bookId': book.uid ?? '',
                                'book': book,
                              },
                            ).then((_) => _refreshBooks());
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((_) => _refreshBooks());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('Authors: ${book.authors.join(', ')}'),
        trailing: Icon(book.isAvailable ? Icons.check_circle : Icons.cancel, color: book.isAvailable ? Colors.green : Colors.red),
        onTap: onTap,
      ),
    );
  }
}
