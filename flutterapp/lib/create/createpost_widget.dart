import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodappproject/create/create_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:foodappproject/flutter_flow/flutter_flow_model.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  late CreateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  Uint8List? _fileBytes; // For web
  File? _file; // For mobile
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateModel());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _model.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });

      if (kIsWeb) {
        // For web
        setState(() {
          _fileBytes = result.files.first.bytes;
        });
      } else {
        // For mobile and desktop
        File file = File(result.files.single.path!);
        setState(() {
          _file = file;
        });
      }
    }
  }

  void _createPost() {
    final title = _titleController.text;
    // Handle the post creation logic here
  }

  void _deleteImage() {
    setState(() {
      _fileBytes = null;
      _file = null;
      _fileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: 'Link',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            if (_fileBytes != null || _file != null)
              Column(
                children: [
                  Container(
                    height: 200,
                    child: _fileBytes != null
                        ? Image.memory(_fileBytes!)
                        : _file != null
                            ? Image.file(_file!)
                            : SizedBox(),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _deleteImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Set button color to red
                    ),
                    child: Text('Delete Image'),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12, // Set button color to red
                    ),
                child: Text('Pick an Image'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12, // Set button color to red
                    ),
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
