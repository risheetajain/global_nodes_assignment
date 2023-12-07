import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_nodes_assignment/routes/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../routes/routes.dart';
import 'firebase_options.dart';
import 'providers/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Global Nodes Assignment',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white),
          fontFamily: GoogleFonts.roboto().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        onGenerateRoute: RoutersPath.generateRoute,
        initialRoute: RouteConstant.splashScreen,
      ),
    );
  }
}
