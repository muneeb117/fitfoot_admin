import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String image;
  final String title;
  final String description;
  final String arLink;
  final int price;
  final int size;
  final String id; // Change this from int to String
  final Color color;

  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.id,
    required this.color,
    required this.arLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'size': size,
      'id': id,
      'color': color.value,
      'arLink': arLink,
    };
  }

  factory Product.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Product(
      image: data['image'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0,
      size: data['size'] ?? 0,
      id: snapshot.id, // Use Firestore document ID as String
      color: Color(data['color'] ?? 0xFFFFFFFF),
      arLink: data['arLink'] ?? '',
    );
  }
}
