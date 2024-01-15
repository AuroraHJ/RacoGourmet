import 'package:flutter/material.dart';
import 'package:supabase_example/screens/search/search.dart';
import 'package:supabase_example/style.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Search',
      home: const SplashScreen(),
      theme: appTheme,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Aquí puedes realizar cualquier lógica necesaria antes de pasar a la pantalla principal
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const Search(), // Reemplaza HomeScreen con tu pantalla principal
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            'assets/2561052.png'), // Muestra el icono en el splash screen
      ),
    );
  }
}
