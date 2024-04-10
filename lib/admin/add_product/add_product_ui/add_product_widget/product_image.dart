import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img.cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/img_upload/img_upload_state.dart';

Widget ProductImage() {
  return Container(
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      // border: Border.all(color: Colors.black)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Product Image',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: BlocConsumer<ImageCubit, ImageUploadState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final imageCubit = context.read<ImageCubit>();
              return
               state is ImageUploading? Center(child: CircularProgressIndicator()):
                   state is ImageUploaded?
                InkWell(
                onTap: () {
                  imageCubit.pickFile();
                },
                child:
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(
                          imageCubit.imageFile
                      )
                    ),
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                  ),
                  height: 200,
                  width: 200,
                ),
              ):Container(
                     child: Center(
                       child: InkWell(
                           onTap: () {
                             imageCubit.pickFile();
                           },
                           child: Text('Browse')),
                     ),
                   )
              ;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'This UI allows users to choose from a selection of pre-existing images or upload their own. The "Continue" button would typically proceed to the next step or action in the process.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
          ),
        )
      ],
    ),
  );
}
