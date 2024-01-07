// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_example/screens/search/tile.dart';
import 'package:supabase_example/style.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/notes_model.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String>? _restaurantResults;
  List<String>? _chefResults;
  String _restaurantInput = '';
  String _chefInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cerca de restaurants',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto aquí
          ),
        ),
        backgroundColor: Color.fromARGB(255, 67, 218, 30),
        actions: [
            IconButton(
              onPressed: () async {
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person),
            )
          ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            onChanged: _onRestaurantSearchFieldChanged,
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Restaurant",
              hintStyle: placeholderTextFieldStyle,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: TextFormField(
        //     style: Theme.of(context).textTheme.bodyText1,
        //     onChanged: _onChefSearchFieldChanged,
        //     autocorrect: false,
        //     decoration: InputDecoration(
        //       hintText: "Xef",
        //       hintStyle: placeholderTextFieldStyle,
        //       border: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //       enabledBorder: InputBorder.none,
        //       errorBorder: InputBorder.none,
        //       disabledBorder: InputBorder.none,
        //     ),
        //   ),
        // ),
Expanded(
 child: (_restaurantResults ?? []).isNotEmpty
      ? GridView.count(
          childAspectRatio: 1,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2.0),
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: _restaurantResults!.map((r) => Tile(r)).toList())
      // : (_chefResults != null && _chefResults!.isNotEmpty)
      //     ? GridView.count(
      //         childAspectRatio: 1,
      //         crossAxisCount: 2,
      //         padding: const EdgeInsets.all(2.0),
      //         mainAxisSpacing: 1.0,
      //         crossAxisSpacing: 1.0,
      //         children: _chefResults!
      //             .map((r) => Tile(r))
      //             .toList(),
      //       )
          : Padding(
              padding: const EdgeInsets.only(top: 200),
              child: (_restaurantResults == null)
                  ? Container()
                  : Text(
                      "No s'han trobat resultats",
                      style: Theme.of(context).textTheme.caption,
                    ),
            ),
)
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: const Icon(Icons.add),
        )
    );
  }

 _onRestaurantSearchFieldChanged(String value) async {
    setState(() {
      _restaurantInput = value;
    });

    if (value.isEmpty) {
      setState(() {
        _restaurantResults = null;
      });
    } else {
      final results = await _searchRestaurants(value);

      setState(() {
        _restaurantResults = results;
      });
    }
  }


  _onChefSearchFieldChanged(String value) async {
    setState(() {
      _chefInput = value;
      if (value.isEmpty) {
        _chefResults = null;
      }
    });

    final results = await _searchChefs(value);

    setState(() {
      _chefResults = results;
    });
  }

  Future<List<String>> _searchRestaurants(String name) async {
  // Replace spaces with the PostgreSQL wildcard character in the search term
  //final sanitizedSearchTerm = name.replaceAll(' ', ':*');
 SupabaseClient client = Supabase.instance.client;

  final result = await Supabase.instance.client
      .from('restaurants')
      .select('nom_rest, ciutat_rest')
      //.match({"uid": client.auth.currentUser!.id})
      .textSearch('rest_fts', "$name:*", config: 'english')
      .limit(100)
      .execute();

  if (result.data == null) {
    print('error: ${result.data.toString()}');
    return [];
  }

  final List<String> names = [];
  for (var v in ((result.data ?? []) as List<dynamic>)) {
    names.add("${v['nom_rest']} (${v['ciutat_rest']})");
  }
  return names;
}
 

  Future<List<String>> _searchChefs(String name) async {
    final result = await Supabase.instance.client
        .from('xefs')
        .select('nom_xef, cognom_xef')
        .textSearch('xef_fts', "$name:*")
        .limit(100)
        .execute();

    if (result.data == null) {
      print('error: ${result.data.toString()}');
      return [];
    }

    final List<String> names = [];
    for (var v in ((result.data ?? []) as List<dynamic>)) {
      names.add("${v['nom_xef']} ${v['cognom_xef']}");
    }
    return names;
  }

}