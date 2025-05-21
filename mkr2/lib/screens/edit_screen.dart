import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/database_service.dart';

class EditScreen extends StatefulWidget {
  final String bookId;
  final Book book;

  const EditScreen({super.key, required this.bookId, required this.book});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late List<String> authors;
  late String publisher;
  late int publicationYear;
  late String librarySection;
  late String origin;
  late bool isAvailable;

  @override
  void initState() {
    super.initState();
    title = widget.book.title;
    authors = widget.book.authors;
    publisher = widget.book.publisher;
    publicationYear = widget.book.publicationYear;
    librarySection = widget.book.librarySection;
    origin = widget.book.origin;
    isAvailable = widget.book.isAvailable;
  }

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedBook = Book(
        title: title,
        authors: authors,
        publisher: publisher,
        publicationYear: publicationYear,
        librarySection: librarySection,
        origin: origin,
        isAvailable: isAvailable,
      );
      await DatabaseService().updateBook(widget.bookId, updatedBook);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value!,
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                initialValue: authors.join(', '),
                decoration: const InputDecoration(labelText: 'Authors (comma-separated)'),
                onSaved: (value) => authors = value!.split(',').map((e) => e.trim()).toList(),
                validator: (value) => value!.isEmpty ? 'Authors are required' : null,
              ),
              TextFormField(
                initialValue: publisher,
                decoration: const InputDecoration(labelText: 'Publisher'),
                onSaved: (value) => publisher = value!,
                validator: (value) => value!.isEmpty ? 'Publisher is required' : null,
              ),
              TextFormField(
                initialValue: publicationYear.toString(),
                decoration: const InputDecoration(labelText: 'Publication Year'),
                keyboardType: TextInputType.number,
                onSaved: (value) => publicationYear = int.parse(value!),
                validator: (value) => value!.isEmpty ? 'Publication year is required' : null,
              ),
              TextFormField(
                initialValue: librarySection,
                decoration: const InputDecoration(labelText: 'Library Section'),
                onSaved: (value) => librarySection = value!,
                validator: (value) => value!.isEmpty ? 'Library section is required' : null,
              ),
              TextFormField(
                initialValue: origin,
                decoration: const InputDecoration(labelText: 'Origin'),
                onSaved: (value) => origin = value!,
                validator: (value) => value!.isEmpty ? 'Origin is required' : null,
              ),
              SwitchListTile(
                title: const Text('Available'),
                value: isAvailable,
                onChanged: (value) => setState(() => isAvailable = value),
              ),
              ElevatedButton(
                onPressed: _updateBook,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
