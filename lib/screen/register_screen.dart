import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:project/provider/services.dart';
import 'package:project/screen/logIn_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: const Color(0xFF121217),
        title: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                "Username",
                style: TextStyle(fontSize: 10.sp, color: Colors.white),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _nameTEController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Email",
                style: TextStyle(fontSize: 10.sp, color: Colors.white),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _emailTEController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              SizedBox(height: 16.h),
              Text(
                "Phone",
                style: TextStyle(fontSize: 10.sp, color: Colors.white),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _phoneTEController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(hintText: 'Enter your phone'),
              ),
              SizedBox(height: 16.h),
              Text(
                "Password",
                style: TextStyle(fontSize: 10.sp, color: Colors.white),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: _passwordTEController,
                obscureText: _obscureText,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.all(8.0).w,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          final name = _nameTEController.text.trim();
                          final email = _emailTEController.text.trim();
                          final password = _passwordTEController.text.trim();
                          final phone = _phoneTEController.text.trim();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields"),
                              ),
                            );
                            return;
                          }

                          bool success = await authProvider.signUp(
                            name,
                            email,
                            password,
                            phone,
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Register Successful"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LogInScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Register Failed")),
                            );
                          }
                        },
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LogInScreen()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Log In",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
