import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/product_state.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/productsmodel.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState([]));

  void fetchProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((snapshot) {
      final List<Product> products = snapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
      emit(ProductState(products));
    });
  }


}