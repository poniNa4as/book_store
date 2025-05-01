import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
      super.key, 
      required this.label, 
      required this.hint, 
      required this.icon,
      this.controller,
      required this.onChange,
      });

  final String label;
  final String hint;
  final Icon icon;
  final Function(String) onChange;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _internalController;
  
  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
      _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _internalController,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        filled: true,
        fillColor: Colors.orange.shade50,
        prefixIcon: widget.icon,
      ),
    );
  }
}
