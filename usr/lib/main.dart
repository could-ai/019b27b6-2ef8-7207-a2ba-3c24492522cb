import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/words_screen.dart';
import 'screens/sentence_screen.dart';
import 'screens/paragraph_screen.dart';

void main() {
  runApp(const LanguageMasterApp());
}

class LanguageMasterApp extends StatelessWidget {
  const LanguageMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/words': (context) => const WordsScreen(),
        '/sentence': (context) => const SentenceScreen(),
        '/paragraph': (context) => const ParagraphScreen(),
      },
    );
  }
}
