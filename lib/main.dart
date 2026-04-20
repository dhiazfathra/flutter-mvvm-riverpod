import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (comment out if not using Firebase)
  // await Firebase.initializeApp();

  runApp(const ProviderScope(child: App()));
}
