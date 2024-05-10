import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:http/http.dart' as http;
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:path/path.dart' as path;

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController postTextController = TextEditingController();
  Uint8List? _fileBytes; // For web
  File? _file; // For mobile/desktop
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });

      if (kIsWeb) {
        setState(() {
          _fileBytes = result.files.first.bytes;
        });
      } else {
        File file = File(result.files.single.path!);
        setState(() {
          _file = file;
        });
      }
    }
  }

  void _removeImage() {
    setState(() {
      _fileBytes = null;
      _file = null;
      _fileName = null;
    });
  }

  Future<void> uploadRecipeImage(String id, File imageFile) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      String mimeType = 'data:image/jpeg;base64,'; // Default to JPEG
      if (path.extension(imageFile.path).toLowerCase() == ".png") {
        mimeType = 'data:image/png;base64,'; // Change to PNG if file is PNG
      }

      String payload = jsonEncode({
        'id': id,
        'image': mimeType + base64Image,
      });

      const url = 'http://localhost:8080/image';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 200) {
        print('File uploaded successfully: ${response.body}');
      } else {
        print('Failed to upload file: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  Future<void> _post() async {
    String username = ""; // Adjust this value as needed
    String caption = postTextController.text;
    String referenceId = ""; // This should be provided as per your application's logic

    if (_file != null) {
      await uploadRecipeImage(referenceId, _file!);
    }

    List<String> payload = [username, caption, referenceId];

    var response = await http.post(
      Uri.parse('http://localhost:8080/api/post/create'), // Change to your actual endpoint
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      _showDialog('Success', 'Post uploaded successfully: ${response.body}');
    } else {
      _showDialog('Error', 'Failed to upload post: ${response.body}');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        title: Text(
          "Create Post",
          style: TextStyle(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme: IconThemeData(
          color: FlutterFlowTheme.of(context).primaryText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: postTextController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Post Content',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            const SizedBox(height: 16),
            _fileBytes != null || _file != null
                ? Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: kIsWeb
                            ? Image.memory(_fileBytes!)
                            : Image.file(_file!),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _removeImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        icon: Icon(
                          Icons.delete,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        label: Text(
                          'Remove Image',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  icon: Icon(
                    Icons.attach_file,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  label: Text(
                    'Add File',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _post,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context). primaryBackground,
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context). primaryText,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
