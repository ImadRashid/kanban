import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final preFixIcon;
  final sufFixIcon;
  final textInputAction;
  final keyBoardType;
  final int maxLines;

  CustomTextField({
    this.preFixIcon,
    this.sufFixIcon,
    this.onChanged,
    this.controller,
    this.hintText,
    this.validator,
    this.textInputAction,
    this.keyBoardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: textFiledContainerStyle,
      child: TextFormField(
        autocorrect: false,
        maxLines: maxLines,
        textInputAction: textInputAction,
        keyboardType: keyBoardType,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        style: TextStyle(fontSize: 14),
        cursorColor: Color(0xFF568C48),
        // style: Theme.of(context).textTheme.bodyText1!,
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: '$hintText',
          prefixIcon: Icon(
            preFixIcon,
            color: Color(0xFF568C48),
          ),
          suffixIcon: sufFixIcon != null
              ? ImageIcon(
                  AssetImage(sufFixIcon),
                  color: Color(0xFF568C48),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
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
