// Importing necessary packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/firebase_options.dart';
import 'package:uber/main_page/bloc.dart';
import 'package:uber/main_page/main_page.dart';

// Main function to run the app
void main() async {
  // Ensuring the widget binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing Firebase with the default options for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Running the app with MyApp as the root widget
  runApp(const MyApp());
}

// MyApp widget which is the root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Returning a MaterialApp widget
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Setting the color scheme of the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Setting the home of the app to MainPage wrapped with a BlocProvider
      home: BlocProvider(create: (_) => MainPageBloc(), child: const MainPage()),
    );
  }
}

// MyHomePage widget which is a stateful widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Title of the home page
  final String title;

  // Creating the state for this widget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State for the MyHomePage widget
class _MyHomePageState extends State<MyHomePage> {
  // Counter to keep track of the number of times the button is pressed
  int _counter = 0;

  // Function to increment the counter
  void _incrementCounter() {
    setState(() {
      // Incrementing the counter
      _counter++;
    });
  }

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Returning a Scaffold widget
    return Scaffold(
      appBar: AppBar(
        // Setting the background color of the AppBar
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Setting the title of the AppBar
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // Floating action button to increment the counter
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
