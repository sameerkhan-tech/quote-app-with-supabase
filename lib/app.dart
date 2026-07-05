import 'package:flutter/material.dart';
import 'package:quote_app_with_supabase/features/quote/view/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}