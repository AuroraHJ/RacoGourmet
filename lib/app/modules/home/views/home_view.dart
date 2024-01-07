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
          title: const Text('HOME'),
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
                      child: Text("NO DATA"),
                    )
                  : ListView.builder(
                      itemCount: controller.allNotes.length,
                      itemBuilder: (context, index) {
                        Restaurants restaurant = controller.allNotes[index];
                        return ListTile(
                          onTap: () => Get.toNamed(
                            Routes.EDIT_NOTE,
                            arguments: restaurant,
                          ),
                          leading: CircleAvatar(
                            child: Text("t${restaurant.id}"),
                          ),
                          title: Text("restaurant: ${restaurant.nom_rest}"),
                          subtitle: Text("ciutat: ${restaurant.ciutat_rest}"),
                          trailing: IconButton(
                            onPressed: () async =>
                                await controller.deleteNote(restaurant.id!),
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
