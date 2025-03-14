import 'package:flutter/material.dart';
import 'package:storeappv2/app/di/dependency_injection.dart';
import 'package:storeappv2/app/main_app.dart';

void main() {

  DependecyInjection.setup();  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

