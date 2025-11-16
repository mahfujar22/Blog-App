import 'package:flutter/material.dart';
import 'package:project/model/post_model.dart';
import 'package:project/provider/services.dart';


class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  final authProvider = AuthProvider();

  List<Posts> allPosts = [];
  List<Posts> filteredPosts = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    allPosts = await authProvider.fetchPosts();
    filteredPosts = allPosts;
    setState(() => loading = false);
  }

  void searchPosts(String text) {
    text = text.toLowerCase();
    filteredPosts = allPosts.where((post) {
      return (post.title ?? "").toLowerCase().contains(text) ||
          (post.content ?? "").toLowerCase().contains(text);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
          backgroundColor: const Color(0xFF121217),
          title: const Text("Books", style: const TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: searchPosts,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white70),
                fillColor: Colors.white70,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final p = filteredPosts[index];
                return Card(
                  color: const Color(0xFF1A1A1E),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        p.featuredImage ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(p.title ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      p.content ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
