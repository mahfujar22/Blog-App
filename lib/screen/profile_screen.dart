import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/screen/logIn_screen.dart';
import 'package:project/screen/up_date_password.dart';
import 'package:project/screen/up_date_profile_screen.dart';
import 'package:provider/provider.dart';
import '../provider/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.token != null && authProvider.data == null) {
        await authProvider.fetchProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profileData = authProvider.data;
    final user = profileData?['user'];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: const Color(0xFF121217),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
          SizedBox(width: 10.w),
        ],
      ),

      backgroundColor: const Color(0xFF121217),

      body: SingleChildScrollView(
        child: authProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : user == null
            ? const Center(
                child: Text(
                  'No profile data found. Please log in',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/mahfujar.png"),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      user['name'] ?? "Unknown User",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      user['email'] ?? "Unknown Email",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpDateProfileScreen(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30.r,
                      ),
                      title: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpDatePassword(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30.r,
                      ),
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
      ),
    );
  }
}
