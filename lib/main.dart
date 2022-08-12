import 'package:flutter/material.dart';
import 'package:foodwastetracker/new_post.dart';
import 'entry_lists.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loading_page.dart';
import 'entry.dart';

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
      'home': (context) => EntryLists(),
      'loading': (context) => LoadingPage(),
    };

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        initialRoute: 'home',
        routes: routes,
        onGenerateRoute: (details) {
          if (details.name == 'camera') {
            final args = details.arguments as Map;
            return MaterialPageRoute(builder: (context) => NewPost(arg: args));
          } else if (details.name == 'entry') {
            final args = details.arguments as Map;
            return MaterialPageRoute(builder: (context) => Entry(arg: args));
          }
          return null;
        });
    //home: Scaffold(body: EntryLists()));
  }
}
