import 'package:flutter/material.dart';
import 'package:supabase_example/screens/search/search.dart';
import 'package:supabase_example/style.dart';
//import 'screens/search/search.dart';
import 'style.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Search',
      home: SplashScreen(),
      theme: appTheme,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Aquí puedes realizar cualquier lógica necesaria antes de pasar a la pantalla principal
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Search(),  // Reemplaza HomeScreen con tu pantalla principal
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/restaurants.png'),  // Muestra el icono en el splash screen
      ),
    );
  }
}


