import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../controllers/uploadProductController.dart';
import '../../routes/route_name.dart';

class ConfirmProductScreen extends StatefulWidget {
  final Uint8List productImageBytes;

  const ConfirmProductScreen({super.key, required this.productImageBytes});

  @override
  _ConfirmProductScreenState createState() => _ConfirmProductScreenState();
}

class _ConfirmProductScreenState extends State<ConfirmProductScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _arLinkController =
      TextEditingController(); // New AR link controller
  final UploadProductController _uploadProductController =
      UploadProductController();
  bool _isUploading = false;

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  Future<void> _uploadProduct() async {
    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all fields before uploading.')));
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Generate random color for the product
      Color randomColor = _generateRandomColor();

      await _uploadProductController.uploadProduct(
        _titleController.text,
        int.parse(_priceController.text),
        _descriptionController.text,
        widget.productImageBytes,
        arLink: _arLinkController.text, // Pass the AR link if available
        colorValue: randomColor.value, // Store the random color
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully.')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload product: ${e.toString()}')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Confirm Product Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _arLinkController,
                    decoration: const InputDecoration(labelText: 'AR Link'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _uploadProduct,
                  child: _isUploading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Upload Product',
                          style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
