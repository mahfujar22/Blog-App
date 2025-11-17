import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/model/comments_model.dart';
import 'package:project/model/post_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  Map<String, dynamic>? _profileData;
  Map<String, dynamic>? get data => _profileData;

  /*------------- Login Section ------------*/
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "https://api.zhndev.site/wp-json/blog-app/v1/auth/login",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        _token = data["token"] ?? data["data"]?["token"] ?? data["jwt_token"];

        return _token != null;
      }

      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /*------------- SignUp Section ------------*/
  Future<bool> signUp(
    String name,
    String email,
    String password,
    String number,
  ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      "https://api.zhndev.site/wp-json/blog-app/v1/auth/register",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "phone": number,
        }),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _token = data["token"] ?? data["data"]?["token"];
        return true;
      }
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /*------------- Fetch Profile (GET) ------------*/
  Future<void> fetchProfile() async {
    if (_token == null) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.zhndev.site/wp-json/blog-app/v1/user/profile',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        _profileData = decoded['data'];
      }
    } catch (e) {
      debugPrint("Profile fetch error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /*------------- Update Profile (put) ------------*/
  Future<bool> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (_token == null) {
      print("ERROR: Token is null!");
      return false;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(
        "https://api.zhndev.site/wp-json/blog-app/v1/user/profile",
      );

      print("==== UPDATE PROFILE API CALL ====");
      print("TOKEN = $_token");
      print("REQUEST BODY = ${jsonEncode({"name": name, "phone": phone})}");
      print("URL = $url");

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"name": name, "phone": phone}),
      );

      print("STATUS CODE = ${response.statusCode}");
      print("RESPONSE BODY = ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        print("DECODED = $decoded");

        if (decoded["success"] == true) {
          print("PROFILE UPDATED SUCCESSFULLY!");
          await fetchProfile();
          return true;
        } else {
          print("API RETURNED success = false");
        }
      } else {
        print("ERROR: Status code not 200");
      }

      return false;
    } catch (e) {
      print("Update error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---------- FETCH COMMENTS ----------
  Future<List<CommentModel>> fetchComments(int postId) async {
    final url = Uri.parse(
        "https://api.zhndev.site/wp-json/blog-app/v1/comments/post/$postId");

    try {
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      print("FETCH COMMENTS STATUS: ${response.statusCode}");
      print("FETCH COMMENTS BODY: ${response.body}");

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final list = body["data"]["comments"] as List;

        return list.map((e) => CommentModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("FETCH COMMENTS ERROR: $e");
      return [];
    }
  }


  // ---------- ADD COMMENT ----------
  Future<bool> addComment(int postId, String text) async {
    final url = Uri.parse("https://api.zhndev.site/wp-json/blog-app/v1/comments");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "post_id": postId,
          "content": text,
          "parent_id": 0,
        }),
      );

      print("ADD COMMENT STATUS: ${response.statusCode}");
      print("ADD COMMENT BODY: ${response.body}");

      return response.statusCode == 201;
    } catch (e) {
      print("ADD COMMENT ERROR: $e");
      return false;
    }
  }



  Future<Map<String, dynamic>> fetchLikes(int postId) async {
    final url = Uri.parse("https://api.zhndev.site/wp-json/blog-app/v1/posts/$postId/like");

    try {
      final response = await http.get(url);

      print("LIKE FETCH STATUS: ${response.statusCode}");
      print("LIKE FETCH BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);



        return {
          "count": data["data"]["like_count"] ?? 0,
          "liked": data["data"]["liked"] ?? false,
        };
      }
      return {"count": 0, "liked": false};
    } catch (e) {
      print("FETCH LIKE ERROR: $e");
      return {"count": 0, "liked": false};
    }
  }


  Future<bool> toggleLike(int postId) async {
    final url = Uri.parse(
        "https://api.zhndev.site/wp-json/blog-app/v1/posts/$postId/like");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
        },
      );

      print("LIKE STATUS: ${response.statusCode}");
      print("LIKE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("TOGGLE LIKE ERROR: $e");
      return false;
    }
  }



  Future<List<Posts>> fetchPosts() async {
    final url = Uri.parse("https://api.zhndev.site/wp-json/blog-app/v1/posts");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      Post post = Post.fromJson(jsonData);
      return post.data!.posts!;
    } else {
      throw Exception("Failed to load posts");
    }
  }




  Future<Map<String, dynamic>> changePassword(
      String currentPass, String newPass) async {

    final url = Uri.parse("https://api.zhndev.site/wp-json/blog-app/v1/user/change-password");

    final body = {
      "current_password": currentPass,
      "new_password": newPass,
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token",
      },
      body: jsonEncode(body),
    );

    print("CHANGE PASSWORD STATUS: ${response.statusCode}");
    print("CHANGE PASSWORD BODY: ${response.body}");

    return jsonDecode(response.body);
  }



}
