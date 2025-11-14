import 'package:flutter/material.dart';
import 'package:project/provider/services.dart';
import 'package:project/abb_bar.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>AuthProvider()),
    ],
      child: BlogApp()
  ),
  );
}


