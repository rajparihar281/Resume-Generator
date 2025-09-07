
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resume_generator/models/resume_model.dart';
import 'package:resume_generator/models/settings_model.dart';
import 'package:resume_generator/screens/home_screen.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();

   // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ResumeDataAdapter());
  Hive.registerAdapter(UserSettingsAdapter());

    // Open boxes
  await Hive.openBox<ResumeData>('resume');
  await Hive.openBox<UserSettings>('settings');
  
  // Request location permissions
  await Permission.location.request();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
