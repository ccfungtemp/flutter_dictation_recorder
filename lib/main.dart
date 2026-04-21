import 'package:flutter/material.dart';
import 'src/presentation/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: '默書錄音',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black, // Set scaffold background to black
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Set app bar background to black
          foregroundColor: Colors.white, // Set app bar text/icon color to white
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, // Set default text color to white
              displayColor: Colors.white,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
