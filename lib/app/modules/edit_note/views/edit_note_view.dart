// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/notes_model.dart';
import 'package:supabase_example/app/modules/home/controllers/home_controller.dart';
import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  Receptes receptes = Get.arguments;
  HomeController homeC = Get.find();
  EditNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = receptes.nomRecepte!;
    controller.descC.text = receptes.preparacio!;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar recepta'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Recepta",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.descC,
              decoration: const InputDecoration(
                labelText: "Preparacio",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.editNote(receptes.idRecepte!);
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "Editar recepta"
                    : "Carregant...")))
          ],
        ));
  }
}
