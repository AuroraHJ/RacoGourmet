// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_example/screens/search/search.dart';
import 'package:supabase_example/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//     url: supaUri,
//     anonKey: supaAnon,
//   );

    Supabase supaProvider = await Supabase.initialize(
      url: 'https://rkxvfridnvtfulgxnydr.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJreHZmcmlkbnZ0ZnVsZ3hueWRyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM3ODQ3MzAsImV4cCI6MjAxOTM2MDczMH0.fAxfmK_0XpXp1zhjzOAOHR9rTv-vMVsGI1gelS5sU-0',    
      debug: true);

  final authC = Get.put(AuthController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: supaProvider.client.auth.currentUser == null
          ? Routes.SPLASH
          : Routes.HOME,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),

  );
}
