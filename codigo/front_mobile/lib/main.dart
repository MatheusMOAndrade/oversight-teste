import '../app.dart';
import '../di/configuration.dart';
import 'package:flutter/material.dart';

void main() async {
  //TODO: Implement this logic after starting to use get it
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
