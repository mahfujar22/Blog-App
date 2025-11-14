import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  final TextEditingController _searchBarTEController = TextEditingController();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  /*
  void _filterProducts(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts
          .where((p) => p.title.toLowerCase().contains(lowerQuery))
          .toList();
    });
  }


  void _updateProduct(Product updated) {
    final iAll = _allProducts.indexWhere((p) => p.id == updated.id);
    if (iAll != -1) _allProducts[iAll] = updated;

    final iFiltered = _filteredProducts.indexWhere((p) => p.id == updated.id);
    if (iFiltered != -1) _filteredProducts[iFiltered] = updated;
  }
*/

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        title: Text(
          'BookMarks',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            TextField(
              controller: _searchBarTEController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search BookMark',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}

Future<void> SearchItem() async {
  final url = "https://api.zhndev.site/wp-json/blog-app/v1/posts/132";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('SearchItem Successfully');
    return data;
  } else {
    throw 'SearchItem filed';
  }
}

/*body: Column(
        children: [
          SizedBox(height: 30),
          TextField(
            controller: _searchBarTEController,
            style:  TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Search BookMark',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),

            ),
           // onChanged: _filterProducts ,

          ),
        ],
      ),*/
