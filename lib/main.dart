import 'package:authentication_imp/ui/screen/login.dart';
import 'package:flutter/material.dart';
void main() {
   WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: SignInPage()
        // SignUpWithEmailPage()
        );
  }
}

