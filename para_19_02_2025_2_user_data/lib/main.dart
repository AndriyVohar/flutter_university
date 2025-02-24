import 'package:flutter/material.dart';
import 'user.dart';

void main() {
  User user = User(
      name: 'Andrii Vohar',
      phoneNumber: '09520000000',
      address: 'Mukachevo'
  );

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User user;
  const MyApp({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(name: user.name, phoneNumber: user.phoneNumber, address: user.address),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  final String name;
  final String phoneNumber;
  final String address;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Andrii\'s Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, $name',
            ),
            Text(
              'Your phone number is $phoneNumber',
            ),
            Text(
              'Your address is $address',
            ),
          ],
        ),
      ),
    );
  }
}