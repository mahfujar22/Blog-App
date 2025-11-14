import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provider/services.dart';
import '../model/product_model.dart';

class BlogHomeScreen extends StatefulWidget {
  const BlogHomeScreen({super.key});

  @override
  State<BlogHomeScreen> createState() => _BlogHomeScreenState();
}

class _BlogHomeScreenState extends State<BlogHomeScreen> {
  late Future<List<Posts>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = AuthProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        title: const Text(
          'Blog',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: FutureBuilder<List<Posts>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading posts:\n${snapshot.error}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No posts found', style: TextStyle(color: Colors.white)),
            );
          }

          final posts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return Card(
                color: const Color(0xFF1C1C25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                elevation: 4.sp,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.featuredImage != null && post.featuredImage!.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              post.featuredImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 180.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180.h,
                                  color: Colors.grey[800],
                                  child: const Center(
                                    child: Icon(Icons.broken_image, color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          post.title ?? "No Title",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          post.excerpt ?? "No description available",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            if (post.author?.avatar != null)
                              CircleAvatar(
                                radius: 15.sp,
                                backgroundImage: NetworkImage(post.author!.avatar!),
                              ),
                            SizedBox(width: 8.h),
                            Text(
                              post.author?.name ?? "Unknown",
                              style: TextStyle(color: Colors.white.withOpacity(0.9)),
                            ),
                            const Spacer(),
                            Icon(Icons.timer, color: Colors.white70, size: 16.sp),
                            SizedBox(width: 4.h),
                            Text(
                              "${post.readTime ?? 0} min read",
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
