import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/product_cubit.dart';
import 'package:flutter_store/ui/userscreen/firestore/user_firestore/product_cubit/product_state.dart';

class ViewProduct extends StatefulWidget {
  ViewProduct({Key? key}) : super(key: key);

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the widget is initialized
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          // Show loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoadedState) {
          // Show loaded products
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                // Add more UI components to display product details
              );
            },
          );
        } else if (state is ProductErrorState) {
          // Show error message
          return Center(
            child: Text('Error: ${state.errorMessage}'),
          );
        } else {
          return Center(
            child: Text('Unknown state'),
          );
        }
      },
    );
  }
}
