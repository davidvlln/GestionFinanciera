import 'package:flutter/material.dart';
import 'package:Caney/Core/utils/app_colors.dart';

class InputText extends StatelessWidget {
  final String placeholder;

  const InputText({super.key, required this.placeholder});
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: AppColors.input,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.input, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secound, width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }
}
