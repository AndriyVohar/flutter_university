import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await readJson();
  }

  Future<void> readJson() async {
    String jsonString = await rootBundle.loadString(
      'assets/mock_data/products.json',
    );
    final jsonData = json.decode(jsonString);
    setState(() {
      items = jsonData['products'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Andrii\'s Flutter App')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                items.isNotEmpty
                    ? items
                        .map<Widget>(
                          (item) => Column(
                            children: [
                              item['image'] != null && item['image'].isNotEmpty
                                  ? Image.network(item['image'])
                                  : Image.asset('assets/images/peakpx.jpg'),
                              Text(item['name']),
                            ],
                          ),
                        )
                        .toList()
                    : [],
          ),
        ),
      ),
    );
  }
}
