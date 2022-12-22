import 'package:flutter/material.dart';
import '../api/http.dart';
import '../components/category_model.dart';

import 'home.dart';

class editCategory extends StatefulWidget {
  const editCategory({super.key, required this.category});

  final Category category;
  @override
  State<editCategory> createState() => _editCategoryState();
}

class _editCategoryState extends State<editCategory> {
  TextEditingController? etCategory;

  doEditCategory() async {
    final name = etCategory?.text;
    final response = await HttpHelper().editCategory(widget.category, name!);
    print(response.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void initState() {
    super.initState();
    etCategory = TextEditingController(text: widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        backgroundColor: Color.fromARGB(255, 28, 46, 183),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: const TextStyle(
                  fontFamily: 'Raleway',
                ),
                controller: etCategory,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'Raleway',
                  ),
                  prefixIcon: const Align(
                    widthFactor: 3.2,
                    heightFactor: 1.5,
                    child: Icon(
                      Icons.card_membership_sharp,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 221, 205, 255)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 208, 205, 255),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 49, 28, 183),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    doEditCategory();
                  },
                  child: const Text(
                    "Edit Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}