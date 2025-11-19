import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/model/comments_model.dart';
import 'package:project/model/product_model.dart';
import 'package:project/provider/services.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final Posts post;

  const DetailsScreen({super.key, required this.post});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late AuthProvider authProvider;

  List<CommentModel> comments = [];
  bool loading = true;
  final TextEditingController commentController = TextEditingController();

  int likesCount = 0;
  bool likedByUser = false;
  bool loadingLikes = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      loadComments();
      loadLikes();
    });
  }

  Future<void> loadComments() async {
    comments = await authProvider.fetchComments(widget.post.id ?? 0);

    setState(() {
      loading = false;
    });
  }

  Future<void> submitComment() async {
    if (commentController.text.isEmpty) return;

    bool success = await authProvider.addComment(
      widget.post.id ?? 0,
      commentController.text,
    );

    if (success) {
      commentController.clear();
      loadComments();
    }
  }

  Future<void> loadLikes() async {
    final data = await authProvider.fetchLikes(widget.post.id ?? 0);
    setState(() {
      likesCount = data['count'];
      likedByUser = data['liked'];
      loadingLikes = false;
    });
  }

  Future<void> toggleLike() async {
    bool success = await authProvider.toggleLike(widget.post.id ?? 0);

    if (success) {
      setState(() {
        likedByUser = !likedByUser;
        likesCount += likedByUser ? 1 : -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121217),

      appBar: AppBar(
        backgroundColor: Color(0xFF121217),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: Image.network(
                widget.post.featuredImage ?? "",
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                widget.post.title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16).w,
              child: Text(
                widget.post.content ?? "",
                style: TextStyle(color: Colors.white70, fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: toggleLike,
                      icon: Icon(
                        likedByUser ? Icons.favorite : Icons.favorite_border,
                        color: likedByUser ? Colors.red : Colors.white,
                        size: 30,
                      ),
                    ),
                    if (!loadingLikes)
                      Positioned(
                        right: 0,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(4).w,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            likesCount.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 20.w),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.comment, color: Colors.white, size: 28),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(4).w,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          comments.length.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Comments",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            loading
                ? Center(child: CircularProgressIndicator(color: Colors.orange))
                : ListView.builder(
                    itemCount: comments.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final c = comments[index];
                      return ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title: Text(
                          c.user,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          c.comment,
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    },
                  ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black26,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    onPressed: submitComment,
                    icon: Icon(Icons.send, color: Colors.orange, size: 28),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
