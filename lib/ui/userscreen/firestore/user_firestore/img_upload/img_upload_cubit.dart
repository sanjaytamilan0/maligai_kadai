import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ImageUploadCubit extends Cubit<int> {
  ImageUploadCubit() : super(0);
  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController imageURL = TextEditingController();
  final cartFireStore = FirebaseFirestore.instance.collection('carts');
  dynamic imageFile;
  String? fileName;
  String? imgDownUrl;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
        imageFile = result.files.first.bytes;
        fileName = result.files.first.name;

    }
    await _uploadImageToFirestore(result!.files.first.bytes!);
  }




  void addProduct() {
    final adding = FirebaseFirestore.instance.collection('products');
    adding.add({
      'id': adding.doc().id,
      'name':  productName.text,
      'description': productDescription.text,
      'price': productPrice.text,
      'imageURL': imageURL.text,
    }).then((_) {
      productName.clear();
      imageURL.clear();
      productPrice.clear();
      productDescription.clear();
    }).catchError((error) {
      print('Error adding product: $error');
    });

  }

  Future<void> _uploadImageToFirestore(Uint8List bytes) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child('images/$fileName');
    UploadTask uploadTask = storageRef.putData(bytes);

    await uploadTask.whenComplete(() async {

      String downloadUrl = await storageRef.getDownloadURL();


      imgDownUrl = downloadUrl;
      imageURL.text = imgDownUrl!;
    });
  }

  Future<void> addToCart(DocumentSnapshot product) async {
    try {
      await cartFireStore.add({
        'cartId' : product['id'],
        'name': product['name'],
        'description': product['description'],
        'price': product['price'],
        'image': product['imageURL']
      });
    } catch (error) {
      print(error);
    }
  }
  Future<void> removeFromCart(String documentId) async {
    try {
      await cartFireStore.doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }

  // void incrementQuantity(newQuantity,prices,id) {
  //   int newQuantity = state + 1;
  //   emit(newQuantity);
  //   updatePrice(newQuantity,prices,id);
  // }
  //
  // void decrementQuantity(newQuantity,prices,id) {
  //   if (state > newQuantity) {
  //     int newQuantity = state - 1;
  //     emit(newQuantity);
  //     updatePrice(newQuantity,prices,id);
  //   }
  // }
  //
  // void updatePrice(int quantity,prices,id) {
  //   double price = double.tryParse(prices) ?? 00;
  //   print(prices);
  //   double totalPrice = price * quantity;
  //   emit(totalPrice.toInt());
  // }
 }
