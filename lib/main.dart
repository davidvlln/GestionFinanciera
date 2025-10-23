import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Core/constants/api_Key.dart';
import 'Presentation/widgets/TextInput.dart';

void main() async {
  await Supabase.initialize(url: ApiKey.url, anonKey: ApiKey.key);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión Financiera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xfff8f9ff),
      ),
      home: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: InputText(placeholder: 'Name'),
          ),
        ),
      ),
    );
  }
}
