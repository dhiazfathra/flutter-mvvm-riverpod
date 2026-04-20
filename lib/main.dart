import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (comment out if not using Firebase)
  // await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
