// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/notes_model.dart';
import 'package:supabase_example/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Restaurants restaurant = Get.arguments;
  HomeController homeC = Get.find();

  EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = restaurant.nom_rest!;
    controller.descC.text = restaurant.ciutat_rest!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Restaurant'),
          centerTitle: true,
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
                    bool res = await controller.editNote(restaurant.id!);
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Editar restaurant" : "Carregant...")))
          ],
        ));
  }
}
