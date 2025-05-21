class Book {
  // Unique identifier for the book
  final String? uid;

  // Book details
  final String title;
  final List<String> authors;
  final String publisher;
  final int publicationYear;

  // Library section (e.g., special literature, hobbies, household, etc.)
  final String librarySection;

  // Origin of the book (e.g., purchased, gifted, inherited, etc.)
  final String origin;

  // Availability status
  final bool isAvailable;

  Book({
    this.uid,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publicationYear,
    required this.librarySection,
    required this.origin,
    required this.isAvailable,
  });

  @override
  String toString() {
    return 'Book(uid: $uid, title: $title, authors: $authors, publisher: $publisher, '
        'publicationYear: $publicationYear, librarySection: $librarySection, '
        'origin: $origin, isAvailable: $isAvailable)';
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'authors': authors,
      'publisher': publisher,
      'publicationYear': publicationYear,
      'librarySection': librarySection,
      'origin': origin,
      'isAvailable': isAvailable,
    };
  }

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      uid: map['uid'],
      title: map['title'],
      authors: List<String>.from(map['authors']),
      publisher: map['publisher'],
      publicationYear: map['publicationYear'],
      librarySection: map['librarySection'],
      origin: map['origin'],
      isAvailable: map['isAvailable'],
    );
  }
}
