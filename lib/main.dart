// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase supaProvider = await Supabase.initialize(
      url: 'https://vuqjsxsnuchfunwbxcwj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ1cWpzeHNudWNoZnVud2J4Y3dqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODU3MDUsImV4cCI6MjAyMDQ2MTcwNX0.Nl0dVvFLdajW4yz9togUbGalwtH98Pth6z1A4DlhaeQ',
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
