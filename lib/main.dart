import 'package:flutter/material.dart';
import 'package:foodwastetracker/camera_screen.dart';
import 'entry_lists.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App(title: 'Location Services'));
}

class App extends StatelessWidget {
  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => EntryLists(),
      'camera': (context) => CameraScreen(),
    };

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: routes,
    );
    //home: Scaffold(body: EntryLists()));
  }
}
