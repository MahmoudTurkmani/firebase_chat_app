import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerInput extends StatefulWidget {
  final void Function(File pickedImage) setUserImage;

  ImagePickerInput(this.setUserImage);

  @override
  _ImagePickerInputState createState() => _ImagePickerInputState();
}

class _ImagePickerInputState extends State<ImagePickerInput> {
  File _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 120,
      imageQuality: 50,
    );
    if (takenImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(takenImage.path);
    });
    widget.setUserImage(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).accentColor,
            backgroundImage:
                _pickedImage == null ? null : FileImage(_pickedImage),
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Take a picture'),
          ),
        ],
      ),
    );
  }
}
