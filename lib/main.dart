import 'package:flutter/material.dart';
import 'package:foodwastetracker/screens/new_post.dart';
import 'screens/entry_lists.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/loading_page.dart';
import 'screens/entry.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App(title: 'Location Services'));
}
