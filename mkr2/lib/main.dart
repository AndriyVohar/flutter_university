import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/add_screen.dart';
import 'screens/view_screen.dart';
import 'screens/edit_screen.dart';
import 'models/book.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/view') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ViewScreen(
              bookId: args['bookId'],
              book: args['book'],
            ),
          );
        } else if (settings.name == '/edit') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EditScreen(
              bookId: args['bookId'],
              book: args['book'],
            ),
          );
        }
        return null;
      },
    );
  }
}
