

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/services.dart';

class UpDateProfileScreen extends StatefulWidget {
  const UpDateProfileScreen({super.key});

  @override
  State<UpDateProfileScreen> createState() => _UpDateProfileScreenState();
}

class _UpDateProfileScreenState extends State<UpDateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);

    print("==== INIT PROFILE DATA ====");
    print("AUTH DATA = ${auth.data}");

    final user = auth.data?['user'];

    print("USER DATA = $user");

    nameController.text = user?['name'] ?? "";
    phoneController.text = user?['phone'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121217),
        leading: IconButton(
          onPressed: () {
            print("BACK PRESSED");
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Update Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/mahfujar.png"),
            ),

            const SizedBox(height: 40),

            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Display Name",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Phone",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),

            const SizedBox(height: 40),

            auth.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                print("==== UPDATE BUTTON PRESSED ====");
                print("NAME = ${nameController.text}");
                print("PHONE = ${phoneController.text}");

                bool success = await auth.updateProfile(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                );

                if (success) {
                  print("SUCCESS! Profile Updated.");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully!"),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  print("FAILED! Profile Not Updated.");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Failed to update profile."),
                    ),
                  );
                }
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
