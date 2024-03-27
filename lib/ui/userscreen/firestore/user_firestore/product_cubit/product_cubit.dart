import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/product_state.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/productsmodel.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoadingState());

  Future<void> fetchProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      final List<Product> products = snapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit( ProductErrorState('Failed to fetch products: $e'));
    }
  }
}
