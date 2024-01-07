// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto aquí
          ),
        ),   
          backgroundColor: Color.fromARGB(255, 67, 218, 30),
          actions: [
            TextButton(
                onPressed: () async {
                  await controller.logout();
                  await authC.resetTimer();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: const Text(
                  "Desconnectar-se",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: FutureBuilder(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      controller.emailC.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    controller: controller.nameC2,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    controller: controller.passwordC,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Nova contrassenya",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            if (controller.nameC.text ==
                                    controller.nameC2.text &&
                                controller.passwordC.text.isEmpty) {
                              // Check if user have same name and not want to change password but they click the button
                              Get.snackbar("Info", "No hi ha canvis",
                                  borderWidth: 1,
                                  borderColor: Colors.white,
                                  barBlur: 100);
                              return;
                            }
                            await controller.updateProfile();
                            if (controller.passwordC.text.isNotEmpty &&
                                controller.passwordC.text.length >= 6) {
                              await controller.logout();
                              await authC.resetTimer();
                              Get.offAllNamed(Routes.LOGIN);
                            }
                          }
                        },
                          style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 42, 233, 24), // Change the button background color here
    foregroundColor: Colors.black,
  ),
                        child: Text(controller.isLoading.isFalse
                            ? "ACTUALITZAR PERFIL"
                            : "Carregant..."),
                      )),
                ],
              );
            }));
  }
}
