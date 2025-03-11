import 'package:flutter/material.dart';
import 'package:namer_app/app/dependency_injection/di.dart';
import 'app/main_app.dart';

void main() {
  DependencyInjection.setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}
