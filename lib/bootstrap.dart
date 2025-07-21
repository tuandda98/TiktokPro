
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart'; // Your MaterialApp widget

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Async initializations
  // All async setup in one place
  runApp(ProviderScope(child: MyApp()));
}
