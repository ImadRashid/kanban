import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final controller;
  final hintText;
  final textInputAction;
  final keyBoardType;
  bool? obscureText;
  IconButton? suffixIcon;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  PasswordTextField(
      {this.onChanged,
      this.controller,
      this.validator,
      this.hintText,
      this.textInputAction,
      this.keyBoardType,
      this.obscureText,
      this.suffixIcon,
      this.focusNode,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: textFiledContainerStyle,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyBoardType,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        obscureText: obscureText!,
        style: TextStyle(fontSize: 14),
        obscuringCharacter: "*",
        // style: Theme.of(context).textTheme.bodyText2!,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          fillColor: Theme.of(context).cardColor,
          filled: true,
          hintText: '$hintText',
          prefixIcon: Icon(Icons.lock, color: Color(0xFF568C48)),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

final textFiledContainerStyle = BoxDecoration(
  color: Colors.grey[300],
  borderRadius: BorderRadius.circular(7),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 3,
      offset: Offset(0, 2),
    ),
  ],
);
