import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screen/blog_home_screen.dart';
import 'package:project/screen/book_marks_screen.dart';
import 'package:project/screen/profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  List<Widget> _screen = [
    BlogHomeScreen(),
    BookMarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.brown,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.grey, size: 30.sp),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: Colors.grey,
              size: 30.sp,
            ),
            label: "BookMarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey, size: 30.sp),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
