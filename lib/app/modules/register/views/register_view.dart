import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
          'Registre',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto aquí
          ),
        ),
          backgroundColor: Color.fromARGB(255, 67, 218, 30),
          // actions: [
          //   IconButton(
          //     onPressed: () async {
          //       Get.back();
          //     },
          //     icon: const Icon(Icons.person),
          //   )
          // ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Change the background color here
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              autocorrect: false,
              controller: controller.nameC,
              textInputAction: TextInputAction.next,
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
              controller: controller.emailC,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: controller.passwordC,
                  textInputAction: TextInputAction.done,
                  obscureText: controller.isHidden.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.isHidden.toggle(),
                        icon: controller.isHidden.isTrue
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined)),
                    labelText: "Contrasenya",
                    border: const OutlineInputBorder(),
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Obx(() => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.signUp();
                    }
                  },
                  
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 42, 233, 24), // Change the button background color here
    foregroundColor: Colors.black,
  ),
                  child: Text(
                      controller.isLoading.isFalse ? "REGISTRE" : "Carregant..."),
                )),
          ],
        ));
  }
}
