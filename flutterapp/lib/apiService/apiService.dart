import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  static const String baseUrl = 'http://localhost:8080/api';

//Post
static Future<List<Post>> getAllPosts() async
 {
    final response = await http.get(Uri.parse('$baseUrl/post/getAll'));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((postJson) => Post.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
    static Future<void> createPost(String username, String caption, String reference, File imageFile) async 
  {
    final url = Uri.parse('$baseUrl/post/create');

    // Read the image file as bytes
    List<int> imageBytes = await imageFile.readAsBytes();

    // Convert the image bytes to base64 string
    String base64Image = base64Encode(imageBytes);

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'username': username,
      'caption': caption,
      'reference': reference,
      'imageData': 'data:image/png;base64,$base64Image', // Include base64 image data
    };
    try {
      // Make the HTTP POST request
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Post created successfully
        print('Post created successfully');
      } else {
        // Failed to create post
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error creating post: $e');
      throw Exception('Failed to create post');
    }
  }
  static Future<void> likePost(String postId, String username) async 
  {
    final response = await http.post(
      Uri.parse('$baseUrl/post/addLike'), 
      body: jsonEncode({
        'id': postId,
        'username': username,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like post');
    }
  }
  static Future<void> dislikePost(String postId, String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post/AddDislike'), // Adjust endpoint accordingly
      body: jsonEncode({
        'id': postId,
        'username': username,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 422) {
      throw Exception('You have dislike or like');
    }
  }

//Recipe


//Account 
  static Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/account/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return "Login successful";
    } else if (response.statusCode == 401) {
      // Check if response body contains error message
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error')) {
        return responseBody['error'];
      } else {
        return "Invalid username or password";
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<String> signUp(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/account/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return "success";
    } else if (response.statusCode == 422) {
      return "Please choose a different username";
    } else {
      throw Exception('Failed to sign up');
    }
  }
}



class Post {

  final String caption;
  final String username;
  final String distinctId;
  final Uint8List? uploadImage;
  final String? userProfilePicture;
  final String? postDate;
  final int? likes;
  final List<Comment> comments;
  final int? dislike;

  Post({
    required this.caption,
    required this.username,
    required this.distinctId,
    this.uploadImage,
    this.userProfilePicture,
    this.postDate,
    this.likes,
    this.comments,
    this.dislike,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // Decode base64 string to Uint8List
    Uint8List? imageBytes;
    if (json['uploadImage'] != null) {
      String? base64Image = json['uploadImage'];
      if (base64Image != null) {
        List<int> decodedBytes = base64Decode(base64Image);
        imageBytes = Uint8List.fromList(decodedBytes);
      }
    }

    // Parse likes and dislikes from dynamic to int
    int? likes = json['like'] is List ? (json['like'] as List).length : json['like'];
    int? dislikes = json['dislike'] is List ? (json['dislike'] as List).length : json['dislike'];

    

    return Post(
      caption: json['caption'] ?? '',
      username: json['username'] ?? '',
      uploadImage: imageBytes,
      userProfilePicture: json['userProfilePicture'],
      postDate: json['postDate'],
      likes: likes,
      dislike: dislikes,
      comments: json['comments'],
      distinctId: json['distinctId'],
    );
  }
}

class Comment 
{
  final String commentBody;
  final String userName; 
  final String distinctId;

  Comment
  ({
    required this.commentBody,
    required this.userName,
    required this.distinctId,
})
}
