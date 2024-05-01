import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

  static Future<void> createPost(String username, String caption,
      String reference, File imageFile) async
  {
    final url = Uri.parse('$baseUrl/post/create');


    List<int> imageBytes = await imageFile.readAsBytes();


    String base64Image = base64Encode(imageBytes);

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'username': username,
      'caption': caption,
      'reference': reference,
      'imageData': 'data:image/png;base64,$base64Image',
      // Include base64 image data
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
    print(username);
    print(postId);
    final response = await http.post(
      Uri.parse('$baseUrl/post/addLike'),
      body: jsonEncode({
        'id': postId,
        'username': username,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 422) {
      throw Exception('You have already liked or disliked');
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

  static Future<Recipe> fetchRecipeById(String id) async {
    // Replace 'port' with the actual port number your API is running on
    final String apiUrl = '$baseUrl/recipe/find';
    final String endpoint = '$id';

    try {
      final response = await http.get(Uri.parse('$apiUrl/$endpoint'));

      if (response.statusCode == 200) {
        // Assuming your response is in JSON format
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Parse the responseData into a Recipe object, assuming Recipe is a class you have defined
        Recipe recipe = Recipe.fromJson(responseData);
        // Handle your response here
        return recipe;
      } else {
        // Handle error
        print('Failed to load recipe, status code: ${response.statusCode}');
        // You can throw an exception here or return null or some default value
        throw Exception('Failed to load recipe');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      // You can throw an exception here or return null or some default value
      throw Exception('Error fetching recipe: $e');
    }
  }
  Future<http.Response?> addRecipe(Recipe recipe, String username) async {
    const url = '$baseUrl/recipe/add';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'recipe': recipe.toJson(),
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful addition
        print('Recipe added successfully: ${response.body}');
      } else {
        // Handle failure
        print('Failed to add recipe: ${response.statusCode}');
      }

      return response;
    } catch (e) {
      print('Error sending request: $e');
      return null;
    }
  }

  Future<void> uploadRecipeImage(String id, File imageFile) async {
    try {
      // Convert to base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Decide the content type based on file extension
      String mimeType = 'data:image/jpeg;base64,'; // Default to JPEG
      if (extension(imageFile.path).toLowerCase() == ".png") {
        mimeType = 'data:image/png;base64,'; // Change to PNG if file is PNG
      }

      // Create JSON payload
      String payload = jsonEncode({
        'id': id,
        'image': mimeType + base64Image,
      });

      // Set the URL for the POST request
      const url = 'http://localhost:8080/image';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 200) {
        print('File uploaded successfully: ${response.body}');
      } else {
        print(
            'Failed to upload file: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }


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
      return "Signup successful";
    } else if (response.statusCode == 422) {
      return "Username Taken";
    } else {
      throw Exception('Failed to sign up');
    }
  }


//Comment
  static Future<List<Comment>> getComments(String postId) async {
    ; // Assuming Spring Boot app is running locally
    final url = '$baseUrl/comment/get/$postId'; // Using postId as part of the URL

    final response = await http.get(
      Uri.parse(url),);
    print(postId);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Comment>.from(l.map((model) => Comment.fromJson(model)));
    } else {
      throw Exception('Failed to load comments');
    }
  }

  static Future<String> createComment(String username, String comment, String postId) async {
    const url = '$baseUrl/comment/create';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([username, comment, postId]),

    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create comment');
    }
  }

  static Future<String> addLikeToComment(String commentId, String username) async {
    const url = '$baseUrl/comment/addLike';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': commentId, 'username': username}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add like');
    }
  }
 static Future<String> addDislike(String commentId, String username) async {
    const url = '$baseUrl/comment/addDislike';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': commentId, 'username': username}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add dislike');
    }
  }


  //Review
  static Future<List<Review>> getReviews(String recipeId) async {
    const url = '$baseUrl/review/getReview';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(recipeId),
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Review>.from(l.map((model) => Review.fromJson(model)));
    } else {
      throw Exception('Failed to load reviews');
    }
  }
  static Future<Review> createReview(String header, String reviewBody, String recipeId, String author, double starRating, double difficultyRating) async {
    const url = '$baseUrl/review/create';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([header, reviewBody, recipeId, author, starRating.toString(), difficultyRating.toString()]),
    );

    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create review');
    }
  }

   static Future<String> addReviewDislike(String reviewId, String personName) async {
    const url = '$baseUrl/review/addDislike';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': reviewId, 'username': personName}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add dislike to review');
    }
  }
  static Future<String> addReviewLike(String reviewId, String personName) async {
    const url = '$baseUrl/review/addLike';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': reviewId, 'username': personName}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add like to review');
    }
  }


//collection

 static Future<List<Collection>> getCollections(String username) async {
    final url = '$baseUrl/collection/getCollection?username=$username';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Collection>.from(l.map((model) => Collection.fromJson(model)));
    } else {
      throw Exception('Failed to load collections');
    }
  }
  static Future<String> createCollection(CollectionNUsername collectionData) async {
    const url = '$baseUrl/collection/create';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(collectionData.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create collection');
    }
  }
  static Future<String> addImageToCollection(String distinctId, String base64Image) async {
    const url = '$baseUrl/collection/addImage';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'distinctId': distinctId, 'uploadImage': base64Image}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add image to collection');
    }
  }





}








//BoilderPlate Class
class Post {
  final String caption;
  final String username;
  final String referenceId;
  final String distinctId;
  final Uint8List? uploadImage;
  final String? userProfilePicture;
  final String? postDate;
  final int? likes;
  final int? dislikes;

  Post({
    required this.caption,
    required this.username,
    required this.referenceId,
    required this.distinctId,
    this.uploadImage,
    this.userProfilePicture,
    this.postDate,
    this.likes,
    this.dislikes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    Uint8List? imageBytes;
    if (json['uploadImage'] != null) {
      String? base64Image = json['uploadImage'];
      if (base64Image != null) {
        List<int> decodedBytes = base64Decode(base64Image);
        imageBytes = Uint8List.fromList(decodedBytes);
      }
    }

    int likes = json['like'] is List ? (json['like'] as List).length : (json['like'] ?? 0);
    int dislikes = json['dislike'] is List ? (json['dislike'] as List).length : (json['dislike'] ?? 0);

    return Post(
      caption: json['caption'] ?? '',
      referenceId: json['reference'] ?? '',
      username: json['username'] ?? '',
      uploadImage: imageBytes,
      postDate: json['postDate']?? '',
      likes: likes,
      dislikes: dislikes,
      distinctId: json['distinctId'],
    );
  }
}

class Comment {
  final String commentBody;
  final int? like;
  final int? dislike;
  final String distinctId;
  final String postId;
  final String username;

  Comment({
    required this.commentBody,
    required this.distinctId,
    required this.postId,
    required this.username,
    this.like,
    this.dislike,
  });

  // Factory constructor to create a Comment from a JSON object
  factory Comment.fromJson(Map<String, dynamic> json) {
    int likes = json['like'] is List ? (json['like'] as List).length : (json['like'] ?? 0);
    int dislikes = json['dislike'] is List ? (json['dislike'] as List).length : (json['dislike'] ?? 0);
    return Comment(
      commentBody: json['commentBody'],
      distinctId: json['distinctId'],
      postId: json['postId'],
      username: json['username'],
      like: likes,
      dislike: dislikes
    );
  }
}


class Recipe {
  final String name;
  final double starRating;
  final double difficultyRating;
  final int servingSize;
  final Uint8List? uploadImage;
  final List<List<String>> ingredients;
  final List<String>? method;
  final String? description;
  final String? backdrop;
  final int? peopleReviewed;

  Recipe({
    required this.name,
    required this.starRating,
    required this.difficultyRating,
    required this.servingSize,
    required this.ingredients,
    this.method,
    this.uploadImage,
    this.description,
    this.backdrop,
    this.peopleReviewed,

  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    Uint8List? imageBytes;
    if (json['uploadImage'] != null) {
      String? base64Image = json['uploadImage'];
      if (base64Image != null) {
        List<int> decodedBytes = base64Decode(base64Image);
        imageBytes = Uint8List.fromList(decodedBytes);
      }
    }
    return Recipe(
      name: json['name'],
      starRating: json['starRating'],
      difficultyRating: json['difficultyRating'],
      servingSize: json['servingSize'],
      ingredients: List<List<String>>.from(json['ingredients'].map((x) => List<String>.from(x))),
      method: json['method'] != null ? List<String>.from(json['method']) : null,
      description: json['description'],
      backdrop: json['backdrop'],
      uploadImage: imageBytes,
      peopleReviewed: json['peopleReviewed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'starRating': starRating,
    'difficultyRating': difficultyRating,
    'servingSize': servingSize,
    'ingredients': ingredients,
    'method': method,
    'description': description,
    'backdrop': backdrop,
    'peopleReviewed': peopleReviewed,
  };
}
class Review {

  final String header;
  final String reviewBody;
  final String recipeId;
  final String author;
  final List<String>? peopleLiked;
  final List<String>? peopleDisliked;

  Review({
    required this.header,
    required this.reviewBody,
    required this.recipeId,
    required this.author,
     this.peopleLiked,
     this.peopleDisliked,
  });

  // Convert a JSON object to a Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      header: json['header'],
      reviewBody: json['reviewBody'],
      recipeId: json['recipeId'],
      author: json['author'],
    );
  }
}

class Collection {
  final String collectionName;
  final List<String> recipeId;

  Collection({
    required this.collectionName,
    required this.recipeId,
  });

  // Convert a JSON object to a Collection
  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      collectionName: json['collectionName'],
      recipeId: List<String>.from(json['recipeId']),
    );
  }

  // Convert a Collection object to JSON
  Map<String, dynamic> toJson() => {
    'collectionName': collectionName,
    'recipeId': recipeId,
  };
}

class CollectionNUsername {
  final String username;
  final Collection collection;

  CollectionNUsername({
    required this.username,
    required this.collection,
  });

  // Convert a JSON object to CollectionNUsername
  factory CollectionNUsername.fromJson(Map<String, dynamic> json) {
    return CollectionNUsername(
      username: json['username'],
      collection: Collection.fromJson(json['collection']),
    );
  }

  // Convert CollectionNUsername to JSON
  Map<String, dynamic> toJson() => {
    'username': username,
    'collection': collection.toJson(),
  };
}



