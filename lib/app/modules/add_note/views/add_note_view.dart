// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_example/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  HomeController homeC = Get.find();

  AddNoteView({super.key}); // get controller from another controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Afegir restaurant',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto aquí
          ),
        ),   
          backgroundColor: Color.fromARGB(255, 67, 218, 30),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Restaurant",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.descC,
              decoration: const InputDecoration(
                labelText: "Ciutat",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.addNote();
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 42, 233, 24), // Change the button background color here
    foregroundColor: Colors.black,
  ),
                child: Text(
                    controller.isLoading.isFalse ? "Afegir restaurant" : "Carregant...")))
          ],
        ));
  }
}
