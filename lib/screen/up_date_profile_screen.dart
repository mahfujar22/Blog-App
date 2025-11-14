import 'package:flutter/material.dart';

class UpDateProfileScreen extends StatefulWidget {
  const UpDateProfileScreen({super.key});

  @override
  State<UpDateProfileScreen> createState() => _UpDateProfileScreenState();
}

class _UpDateProfileScreenState extends State<UpDateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121217),
      appBar: AppBar(
        backgroundColor: Color(0xFF121217),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Update Profile",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 70.0),
            TextField(decoration: InputDecoration(hintText: "Display name")),
            SizedBox(height: 30.0),
            TextField(decoration: InputDecoration(hintText: "email")),
            SizedBox(height: 30.0),
            TextField(decoration: InputDecoration(hintText: "bio")),
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Save Changes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
