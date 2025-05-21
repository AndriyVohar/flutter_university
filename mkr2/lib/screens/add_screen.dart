import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/database_service.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  List<String> authors = [];
  String publisher = '';
  int publicationYear = 0;
  String librarySection = '';
  String origin = '';
  bool isAvailable = true;

  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newBook = Book(
        title: title,
        authors: authors,
        publisher: publisher,
        publicationYear: publicationYear,
        librarySection: librarySection,
        origin: origin,
        isAvailable: isAvailable,
      );
      await DatabaseService().addBook(newBook);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value!,
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Authors (comma-separated)'),
                onSaved: (value) => authors = value!.split(',').map((e) => e.trim()).toList(),
                validator: (value) => value!.isEmpty ? 'Authors are required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Publisher'),
                onSaved: (value) => publisher = value!,
                validator: (value) => value!.isEmpty ? 'Publisher is required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Publication Year'),
                keyboardType: TextInputType.number,
                onSaved: (value) => publicationYear = int.parse(value!),
                validator: (value) => value!.isEmpty ? 'Publication year is required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Library Section'),
                onSaved: (value) => librarySection = value!,
                validator: (value) => value!.isEmpty ? 'Library section is required' : null,
              ),
              TextFormField(
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
                onPressed: _addBook,
                child: const Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
