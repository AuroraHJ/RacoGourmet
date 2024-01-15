import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nameC2 = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<void> logout() async {
    await client.auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getProfile() async {
    List<dynamic> res = await client
        .from("usuaris")
        .select()
        .match({"id": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    nameC.text = user["nom"];
    nameC2.text = user["cognoms"];
    emailC.text = user["email"];
  }

  Future<void> updateProfile() async {
    if (nameC2.text.isNotEmpty) {
      isLoading.value = true;
      await client.from("usuaris").update({
        "cognoms": nameC2.text,
      }).match({"id": client.auth.currentUser!.id});
      // if user want to update password
      if (passwordC.text.isNotEmpty) {
        if (passwordC.text.length >= 6) {
          try {
            await client.auth.updateUser(UserAttributes(
              password: passwordC.text,
            ));
          } catch (e) {
            Get.snackbar("ERROR", e.toString());
          }
        } else {
          Get.snackbar("ERROR", "La contrasenya ha de tenir 6 caràcters com a mínim");
        }
      }
      Get.defaultDialog(
          barrierDismissible: false,
          title: "Actualtizat amb èxit!",
          middleText: "S'actualitzaran els camps corresponents",
          actions: [
            OutlinedButton(
                onPressed: () {
                  Get.back(); //close dialog
                  Get.back(); //back to login page
                },
                child: const Text("OK"))
          ]);
      isLoading.value = false;
    }
  }
}
