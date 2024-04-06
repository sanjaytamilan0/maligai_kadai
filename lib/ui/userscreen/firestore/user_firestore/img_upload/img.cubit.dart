import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img_upload_state.dart';

import 'category_model.dart';

class ImageCubit extends Cubit<ImageUploadState>{
  ImageCubit():super(ImageUploadInitial());

  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController imageURL = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController categoryName = TextEditingController();
  final CollectionReference categoryDb = FirebaseFirestore.instance.collection('categories');
  final cartDb = FirebaseFirestore.instance.collection('carts');
  final productsDb = FirebaseFirestore.instance.collection('Products');
  List<Category> categoriesList = [];
 dynamic imageFile;
  String? fileName;
  String? imgDownUrl;
  bool next = false;
   bool searchbar = false;

  void emitLoading(){
    emit(ImageUploading());
  }

  Future<void> pickFile() async {
    emit(ImageUploading());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      imageFile = result.files.first.bytes;
      fileName = result.files.first.name;

    }
    await _uploadImageToFirestore(result!.files.first.bytes!);
    emit(ImageUploaded(imgDownUrl!));
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

  void addProduct() {
    productsDb.add({
      'id': productsDb.doc().id,
      'name':  productName.text,
      'description': productDescription.text,
      'price': productPrice.text,
      'imageURL': imageURL.text,
      'qty': quantity.text
    }).then((_) {
      productName.clear();
      imageURL.clear();
      productPrice.clear();
      productDescription.clear();
      quantity.clear();
    }).catchError((error) {
      print('Error adding product: $error');
    });

  }
  void addCategoryImage(){
    categoryDb.add(
      {
        'category' : categoryName.text,
        'categoryImage': imageURL.text,
        'id': categoryDb.doc().id
      }
    ).then((_) {
      categoryName.clear();
      imageURL.clear();
      imageFile ='';
    });
  }



Future getDataFromFireStoreCategory() async{
   await categoryDb.get().then(
          (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
              (DocumentSnapshot doc) {
            categoriesList.add(Category.fromFirestore(doc));
          },
        );
      },
    );
  }

  Future<void> addToCart(DocumentSnapshot product) async {
    try {
      final QuerySnapshot cartSnapshot = await cartDb
          .where('name', isEqualTo: product['name'])
          .get();
      if (cartSnapshot.docs.isNotEmpty) {
        print('Item already exists in the cart.');
        return;
      }
      await cartDb.add({
        'cartId': cartDb.doc().id,
        'name': product['name'],
        'description': product['description'],
        'price': product['price'],
        'image': product['imageURL'],
        'Qty': 1,
        'cartPrice': product['price'],
        'favorite': product['favorite']
      });
    } catch (error) {
      print(error);
    }
  }


}