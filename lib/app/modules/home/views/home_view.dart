import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/notes_model.dart';
import 'package:supabase_example/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('INICI'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
        body: FutureBuilder(
            future: controller.getAllNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Obx(() => controller.allNotes.isEmpty
                  ? const Center(
                      child: Text("NO HI HA INFORMACIO"),
                    )
                  : ListView.builder(
                      itemCount: controller.allNotes.length,
                      itemBuilder: (context, index) {
                        Receptes receptes = controller.allNotes[index];
                        return ListTile(
                          onTap: () => Get.toNamed(
                            Routes.EDIT_NOTE,
                            arguments: receptes,
                          ),
                          leading: CircleAvatar(
                            child: Text("t${receptes.idRecepte}"),
                          ),
                          title: Text("titol: ${receptes.nomRecepte}"),
                          subtitle: Text("preparacio: ${receptes.preparacio}"),
                          trailing: IconButton(
                            onPressed: () async => await controller
                                .deleteNote(receptes.idRecepte!),
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: const Icon(Icons.add),
        ));
  }
}
