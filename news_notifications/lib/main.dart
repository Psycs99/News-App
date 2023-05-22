import 'package:flutter/material.dart';
import 'package:news_notifications/src/pages/exportPage.dart';
import 'package:news_notifications/src/services/news_service.dart';
import 'package:news_notifications/src/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: const TabsScreen(),
      ),
    );
  }
}
