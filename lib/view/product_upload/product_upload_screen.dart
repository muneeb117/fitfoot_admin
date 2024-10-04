import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';

import '../../components/custom_button.dart';
import '../../models/product.dart';
import '../../routes/route_name.dart';
import 'confirm_product_arguments.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickAndNavigateToConfirmScreen() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      // Navigate to the confirm product screen
      GoRouter.of(context).goNamed(
        AppRouteNames.confirmProduct,
        extra: ConfirmProductScreenArguments(
          productImageBytes: fileBytes,
        ),
      );
    }
  }

  Widget _buildProductList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            Product product = Product.fromSnap(doc);
            return ListTile(
              leading: SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image, color: Colors.red);
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
              title: Text(product.title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text("Price: \Rs.${product.price}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editProduct(product),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteProduct(product.id),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _editProduct(Product product) {
    TextEditingController titleController =
        TextEditingController(text: product.title);
    TextEditingController priceController =
        TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                _updateProductDetails(product.id, titleController.text,
                    int.parse(priceController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateProductDetails(
      String productId, String newTitle, int newPrice) async {
    await _firestore.collection('products').doc(productId).update({
      'title': newTitle,
      'price': newPrice,
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product details updated successfully')));
  }

  void _deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Product Upload Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPress: _pickAndNavigateToConfirmScreen,
              text: "Upload New Product",
            ),
            const SizedBox(height: 20),
            const Text("Uploaded Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Expanded(
              child: _buildProductList(),
            ),
          ],
        ),
      ),
    );
  }
}
