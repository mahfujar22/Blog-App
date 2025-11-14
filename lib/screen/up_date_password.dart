import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpDatePassword extends StatefulWidget {
  const UpDatePassword({super.key});

  @override
  State<UpDatePassword> createState() => _UpDatePasswordState();
}

class _UpDatePasswordState extends State<UpDatePassword> {
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
        title: Text(
          "UpDate password",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120.h),
            Text(
              "current password",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            SizedBox(height: 6.h),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your current password',
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              "New password",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            SizedBox(height: 6.h),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(hintText: 'Enter New password'),
            ),
            SizedBox(height: 14.h),
            Text(
              "confirm password",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            SizedBox(height: 6.h),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your confirm password',
              ),
            ),
            SizedBox(height: 150.h),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Update password",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
