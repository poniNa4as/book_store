import 'package:book_store/app/pages/custom_app_bar.dart';
import 'package:book_store/app/pages/custom_text_field.dart';
import 'package:book_store/app/providers/put_to_firebase.dart';
import 'package:book_store/app/utilites/books.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submitForm() async {
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _yearController.text.isEmpty ||
        _imageController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _pagesController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      print("Please fill in all fields.");
      return;
    }

    final formData = Book(
      title: _titleController.text,
      author: _authorController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      published: int.tryParse(_yearController.text) ?? 0,
      image: _imageController.text,
      description: _descriptionController.text,
      rate: double.tryParse(_rateController.text) ?? 0.0,
      pages: int.tryParse(_pagesController.text) ?? 0,
    );

    try {
      await PutToFirebase.putNewBook(formData);
      _showSuccessDialog("Book added successfully!");
    } catch (e) {
      _showErrorDialog("Failed to add book. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  List<Widget> fields = [
    CustomTextField(
      label: 'Title',
      hint: 'Title',
      icon: const Icon(Icons.title_rounded),
      controller: _titleController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Author',
      hint: 'Author',
      icon: const Icon(Icons.face_2_rounded),
      controller: _authorController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Price',
      hint: 'Price',
      icon: const Icon(Icons.price_change),
      controller: _priceController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Year',
      hint: 'Year',
      icon: const Icon(Icons.calendar_month),
      controller: _yearController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Image',
      hint: 'Image',
      icon: const Icon(Icons.image),
      controller: _imageController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Rate',
      hint: 'Rate',
      icon: const Icon(Icons.star_rate),
      controller: _rateController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Pages',
      hint: 'Pages',
      icon: const Icon(Icons.bookmark_add),
      controller: _pagesController,
      onChange: (value) {},
    ),
    CustomTextField(
      label: 'Description',
      hint: 'Description',
      icon: const Icon(Icons.tips_and_updates_rounded),
      controller: _descriptionController,
      onChange: (value) {},
    ),
  ];

  return Scaffold(
    appBar: const CustomAppBar(title: 'Create new'),
    body: Container(
      decoration: const BoxDecoration(),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: fields.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => fields[index],
      ),
    ),
    bottomSheet: Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:  Color.fromRGBO(225, 225, 225, 0.3),
            blurRadius: 10,
            offset:  Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
            ),
            child: const Text(
              'Add Book',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ),
  );
}

}
