import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/provider/services.dart';
import 'package:provider/provider.dart';

class UpDatePassword extends StatefulWidget {
  const UpDatePassword({super.key});

  @override
  State<UpDatePassword> createState() => _UpDatePasswordState();
}

class _UpDatePasswordState extends State<UpDatePassword> {
  final TextEditingController currentPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    return Scaffold(
      backgroundColor: Color(0xFF121217),
      appBar: AppBar(
        toolbarHeight: 80.h,
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
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120.h),
            Text(
              "current password",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: currentPassController,
              obscureText: _obscureText,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              "New password",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: newPassController,
              obscureText: _obscureText,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.h),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final current = currentPassController.text.trim();
                  final newPass = newPassController.text.trim();

                  if (current.isEmpty || newPass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill both fields")),
                    );
                    return;
                  }
                  final response = await authProvider.changePassword(
                    current,
                    newPass,
                  );
                  if (response["success"] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password updated successfully")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response["message"] ?? "Something went wrong",
                        ),
                      ),
                    );
                  }
                },
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
