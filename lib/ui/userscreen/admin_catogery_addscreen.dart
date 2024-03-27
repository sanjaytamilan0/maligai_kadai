import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firestore/user_firestore/img_upload/img.cubit.dart';
import 'firestore/user_firestore/img_upload/img_upload_state.dart';

class AdminCategoryAddScreen extends StatelessWidget {
  const AdminCategoryAddScreen({super.key});


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> addCategoryForm = GlobalKey<FormState>();
    final imageCubit = context.read<ImageCubit>();

    return BlocConsumer<ImageCubit, ImageUploadState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is ImageUploading
            ? CircularProgressIndicator()
            : Form(
          key: addCategoryForm,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 550,
              width: 450,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          if (context.read<ImageCubit>().imageFile !=
                              null)
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: MemoryImage(context
                                      .read<ImageCubit>()
                                      .imageFile),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: imageCubit.categoryName,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(14),
                        ],
                        decoration: const InputDecoration(
                          hintText: 'CategoryName',
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        validator: (productName) {
                          if (productName!.isEmpty) {
                            return 'Enter Product name';
                          }
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:
                              context.read<ImageCubit>().imageURL,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),
                                ),
                                hintText: 'Image URL',
                              ),
                              validator: (imageURL) {
                                if (imageURL!.isEmpty) {
                                  return 'Enter Product ImageURL';
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // myUploadCubit.pickFile();
                              context.read<ImageCubit>().pickFile();
                            },
                            child: const Text('Select Image'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (addCategoryForm.currentState!.validate()) {
                            context.read<ImageCubit>().addCategoryImage();

                            WidgetsBinding.instance!
                                .addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Category add Successfully',
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  backgroundColor: Colors.green,
                                  elevation: 13,
                                  margin: EdgeInsets.all(30),
                                  duration: Duration(seconds: 5),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          } else {
                            WidgetsBinding.instance!
                                .addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                    child: Text(
                                      'Fill Required fields',
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  elevation: 13,
                                  margin: EdgeInsets.all(30),
                                  duration: Duration(seconds: 5),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          }
                        },
                        child: const Text('Add Product'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
