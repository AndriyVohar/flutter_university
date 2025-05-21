import 'dart:collection';

import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:para_19_02_2025_2_user_data/states/app_state.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  TextEditingController selectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await ref.read(appProvider.notifier).fetchDormitoryList();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appProvider);
    final appStateNotifier = ref.read(appProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appState.dormitoryList.isEmpty
              ? const CircularProgressIndicator()
              : DropdownMenu(
                initialSelection: appState.selectedDormitoryId,
                controller: selectController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                // On mobile platforms, this is false by default. Setting this to true will
                // trigger focus request on the text field and virtual keyboard will appear
                // afterward. On desktop platforms however, this defaults to true.
                requestFocusOnTap: true,
                label: const Text('Select dormitory'),
                onSelected: (dormitoryId) {
                  setState(() {
                    appStateNotifier.setSelectedDormitoryId(
                      dormitoryId.toString(),
                    );
                  });
                },
                dropdownMenuEntries: UnmodifiableListView(
                  appState.dormitoryList.map(
                    (dormitory) => DropdownMenuEntry(
                      value: dormitory['id'],
                      label: dormitory['name'],
                    ),
                  ),
                ),
              ),
          Image.network(
            appState.dormitoryList.firstWhere(
              (element) =>
                  element['id'].toString() ==
                  appState.selectedDormitoryId.toString(),
              orElse: () => {'img_url': ''},
            )['img_url'],
            width: 200,
            height: 200,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey,
                  child: const Center(child: Text('Image not available')),
                ),
          ),
        ],
      ),
    );
  }
}
