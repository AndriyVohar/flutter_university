import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _users = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
      'assets/mock_data/users.json',
    );
    final data = await json.decode(response);

    setState(() {
      _users = data["users"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Flutter App')),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  ElevatedButton(child: Text('Get Users'), onPressed: readJson),

                  // Display the data loaded from sample.json
                  _users.isNotEmpty
                      ? Expanded(
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder:
                              (context, index) => Row(
                                children: [
                                  Image.network(
                                    "https://lh3.googleusercontent.com/a/ACg8ocJ04H9jaKTBfLYUJZ9q5ux8XXd9lqVhl6ZXoUeTdGSOotDhrr8d=s192-c-mo",
                                    height: 50,
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(_users[index]["id"].toString()),
                                      Text(_users[index]["name"]),
                                      Text(_users[index]["phoneNumber"]),
                                    ],
                                  ),
                                ],
                              ),
                        ),
                      )
                      : Positioned(
                        top: 20,
                        child: Text(
                          'Join us !  ',
                          style: TextStyle(
                            fontSize: 40,
                            // fontFamily: 'Whisper',
                            color: Colors.blue[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
