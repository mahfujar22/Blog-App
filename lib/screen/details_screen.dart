import 'package:flutter/material.dart';
import '../model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Posts post;

  const DetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined,
                color: Colors.white, size: 30),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                post.featuredImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.title ?? "No Title",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: CircleAvatar(
                child: Image.network(
                  post.featuredImage ?? "",
                  fit: BoxFit.cover,
                ),
              ) ,
              title: Text(
                (post.title ?? "").split(" ")[0],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                (post.excerpt ?? "").split("")[1],
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              child: Column(
                children: [
                  Text(
                    post.content ?? "",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white70,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.favorite_border,color: Colors.grey,size: 30,),
                ),
                const SizedBox(width: 40),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.comment,color: Colors.grey,size: 30,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
