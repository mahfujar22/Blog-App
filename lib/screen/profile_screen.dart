import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screen/up_date_password.dart';
import 'package:project/screen/up_date_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121217),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Color(0xFF121217),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/mahfujar.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 100),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpDateProfileScreen(),
                  ),
                );
              },
              leading: Icon(Icons.edit, color: Colors.white),
              title: Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpDatePassword()),
                );
              },
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SizedBox(height: 70),
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Container(
//       height: 40,
//       width: 40,
//       decoration: BoxDecoration(
//         color: Colors.grey,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.edit, color: Colors.white70, size: 30),
//     ),
//     TextButton(
//       onPressed: () {},
//       child: Text(
//         'Edit Profile',
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 18,
//           color: Colors.white70,
//         ),
//       ),
//     ),
//   ],
// ),

// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Container(
//       height: 40,
//       width: 40,
//       decoration: BoxDecoration(
//         color: Colors.grey,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(Icons.edit, color: Colors.white70, size: 30),
//     ),
//     TextButton(
//       onPressed: () {},
//       child: Text(
//         'Update Password',
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 18,
//           color: Colors.white70,
//         ),
//       ),
//     ),
//   ],
// ),
