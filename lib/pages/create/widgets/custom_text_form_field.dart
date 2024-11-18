import 'package:flutter/material.dart';
import 'package:future_hub_test/constants/size.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required TextEditingController titleController,
    required this.labelText,
    required this.errorText,
  }) : _titleController = titleController;

  final String labelText;
  final String errorText;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: CustomSize.marginSmall),
      child: TextFormField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.blue[800], // Label text color (clearer)
            fontWeight: FontWeight.bold, // Bold label text
          ),
          filled: true, // Fill background with color
          fillColor: Colors.blue[50], // Light blue background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: const BorderSide(
              color: Colors.blue, // Border color
              width: 2, // Border width
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: const BorderSide(
              color: Colors.blueAccent, // Border color when focused
              width: 2, // Border width when focused
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: BorderSide(
              color: Colors.blue[200]!, // Border color when enabled
              width: 2, // Border width when enabled
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: const BorderSide(
              color: Colors.red, // Red border when there's an error
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: const BorderSide(
              color: Colors.redAccent, // Red border when focused on error
              width: 2,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto, // Make label float above input
        ),
        style: TextStyle(
          color: Colors.blue[800], // Text color
          fontSize: 18, // Font size
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
      ),
    );
  }
}