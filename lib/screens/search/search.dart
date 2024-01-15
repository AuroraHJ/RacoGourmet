// ignore_for_file: deprecated_member_use, unused_element
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_example/screens/search/tile.dart';
import 'package:supabase_example/style.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/routes/app_pages.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String>? _receptesResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Busca la teva recepta ideal!',
            style: TextStyle(
              color: Colors.white, 
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 144, 242),
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
              onChanged: _onReceptesSearchFieldChanged,
              autocorrect: false,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Receptes",
                hintStyle: placeholderTextFieldStyle,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: (_receptesResults ?? []).isNotEmpty
                ? GridView.count(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(2.0),
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    children: _receptesResults!.map((r) => Tile(r)).toList())
                : Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: (_receptesResults == null)
                        ? Container()
                        : Text(
                            "No s'ha trobat cap recepta amb aquest nom",
                            style: Theme.of(context).textTheme.caption,
                          ),
                  ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: const Icon(Icons.add),
        ));
  }

  _onReceptesSearchFieldChanged(String value) async {
    setState(() {});

    if (value.isEmpty) {
      setState(() {
        _receptesResults = null;
      });
    } else {
      final results = await _searchReceptes(value);

      setState(() {
        _receptesResults = results;
      });
    }
  }

  Future<List<String>> _searchReceptes(String name) async {
    final result = await Supabase.instance.client
        .from('receptes')
        .select('titol, preparacio')
        .textSearch('receptes_fts', "$name:*")
        .limit(100)
        .execute();

    if (result.data == null) {
      print('error: ${result.data.toString()}');
      return [];
    }

    final List<String> names = [];
    for (var v in ((result.data ?? []) as List<dynamic>)) {
      names.add("${v['titol']} (${v['preparacio']})");
    }
    return names;
  }
}
