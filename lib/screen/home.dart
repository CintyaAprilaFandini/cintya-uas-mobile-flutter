// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/category_model.dart';
import '../screen/edit_category.dart';
import '../components/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/http.dart';
import '../api/category.dart';


class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String token = '';
  String name = '';
  String email = '';
  List listCategory = [];
  TextEditingController etCategory = TextEditingController();

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      const key = 'token';
      const key1 = 'name';
      const key2 = 'email';
      final value = pref.get(key);
      final value1 = pref.get(key1);
      final value2 = pref.get(key2);
      token = '$value';
      name = '$value1';
      email = '$value2';
    });
  }
  getKategori() async {
    final response = await HttpHelper().getKategori();
    var dataResponse = jsonDecode(response.body);
    setState(() {
      var listRespon = dataResponse['data'];
      for (var i = 0; i < listRespon.length; i++) {
        listCategory.add(Category.fromJson(listRespon[i]));
      }
    });
  }
  doAddCategory() async {
    final name = etCategory.text;
    final response = await CategoryService().addCategory(name);
    print(response.body);
    listCategory.clear();
    getKategori();
    etCategory.clear();
  }
   @override
  void initState() {
    getPref();
    super.initState();
    getKategori();
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("token");
      preferences.clear();
    });
    final response = await HttpHelper().logout(token);
    print(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 46, 183),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 46, 183),
            ),
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome $name',
                      style: TextStyle(
                        color: Color.fromARGB(255, 122, 0, 253),
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        fontFamily: 'Raleway',
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 28, 46, 183),
                            blurRadius: 6,
                            offset: const Offset(4.0, 4.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          email,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 245, 245),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.logout_sharp,
                            color: Color.fromARGB(255, 245, 150, 150),
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                            logOut();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: TextFormField(
              controller: etCategory,
              decoration: InputDecoration(
                hintText: "Input Your Categories Name",
                hintStyle: const TextStyle(fontFamily: 'Raleway'),
                filled: true,
                fillColor: Color.fromARGB(255, 247, 126, 126),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 169, 0, 0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 250, 127, 127),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 131, 68, 68),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text("Add"),
                    onPressed: () {
                      doAddCategory();
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 58, 58),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: ListView.builder(
                itemCount: listCategory.length,
                itemBuilder: (context, index) {
                  var kategori = listCategory[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Color.fromARGB(255, 238, 52, 52),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.create_rounded,
                              color: Color.fromARGB(255, 226, 113, 113),
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Color.fromARGB(255, 82, 91, 255),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  editCategory(category: listCategory[index]),
                            ));
                      } else {
                        final response = await HttpHelper()
                            .deleteCategory(listCategory[index]);
                        print(response.body);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 7,
                            offset: Offset(6.0, 6.0),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            kategori.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}