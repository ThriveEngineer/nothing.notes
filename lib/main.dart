import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nothing_note/irno/firebase_options.dart';
import 'package:nothing_note/services/auth.dart';
import 'package:nothing_note/services/firebase_api.dart';
import 'package:nothing_note/services/task_provider.dart';
import 'package:nothing_note/tasks_page.dart';
import 'package:nothing_note/theme.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(create: (context) => themeProvider,
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
        theme: Provider.of<ThemeProvider>(context).themeData,
        navigatorKey: navigatorKey,
        routes: {
      '/tasks_page': (context) => const TasksPage(),
    },
      ),
    );
  }
}
