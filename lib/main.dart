import 'package:finances/controllers/screen_controller.dart';
import 'package:finances/providers/finance_provider.dart';
import 'package:finances/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final financeProvider = FinanceProvider();
  final pageProvider = PageProvider();

  await financeProvider.loadFormPrefs();
  await pageProvider.loadFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => financeProvider),
        ChangeNotifierProvider(create: (_) => pageProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: const ScreenController(),
    );
  }
}
