import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String categoryImage;
  final String category;

  Category({
    required this.category,
    required this.id,
    required this.categoryImage,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Document data not available');
    }

    return Category(
      categoryImage: data['categoryImage'] ?? '',
      category: data['category'] ?? '',
      id: data['id'] ?? '',
    );
  }
}
