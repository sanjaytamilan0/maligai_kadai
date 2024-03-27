import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';


class Favorite extends StatefulWidget {

  Favorite({Key? key ,}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Uint8List? imageFile;
  String? fileName;
  String? imageUrl;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        imageFile = result.files.first.bytes;
        fileName = result.files.first.name;

      });

      await _uploadImageToFirestore(result.files.first.bytes!);
    }
  }

  Future<void> _uploadImageToFirestore(Uint8List bytes) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child('images/$fileName');
    UploadTask uploadTask = storageRef.putData(bytes);

    await uploadTask.whenComplete(() async {
      String downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    });
  }

  void addProduct() {
    if (imageUrl != null && fileName != null) {
      FirebaseFirestore.instance.collection('products').add({
        'imageURL': imageUrl!,
        // Add other product details as needed
      }).then((_) {
        // Product added successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
      }).catchError((error) {
        print('Error adding product: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding product: $error')),
        );
      });
    } else {
      print('Image URL or file name is null');
    }
  }

  @override
  Widget build(BuildContext context) {


    return   Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imageFile != null)
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(imageFile!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            const Text('No image picked'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickFile,
            child: const Text('Pick an image file'),
          ),
          const SizedBox(height: 20),
          if (fileName != null) Text('File Name: $fileName'),
          if (imageUrl != null) Text('Image URL: $imageUrl'),
          TextButton(
            onPressed: addProduct,
            child: const Text('ADD product'),
          ),
          Container(

            height: 100,
            width:100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 4
              ),
              image:  DecorationImage(

                image: NetworkImage(
                    imageUrl.toString()
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}
