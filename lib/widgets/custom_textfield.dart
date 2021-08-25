import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';
import 'package:task_manager/constants/styles.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final controller;
  final hintText;
  final bool autoFocus;
  final isPasswordTextField;
  final TextInputType? keyboardType;
  final textInputAction;
  final labelText;
  bool obscureText;
  final validator;

  CustomTextFormField.regular(
      {this.controller,
      this.hintText,
      this.autoFocus = false,
      this.isPasswordTextField = false,
      this.keyboardType,
      this.textInputAction,
      this.labelText,
      this.obscureText = false,
      this.validator});

  CustomTextFormField.password(
      {this.controller,
      this.hintText,
      this.autoFocus = false,
      this.isPasswordTextField = true,
      this.keyboardType = TextInputType.text,
      this.textInputAction,
      this.labelText,
      this.obscureText = true,
      this.validator});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kPoppins.copyWith(fontSize: 15, fontWeight: FontWeight.normal),
      controller: widget.controller,
      autofocus: widget.autoFocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: kPoppins.copyWith(fontSize: 15),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blue),
        ),
        hintText: widget.hintText,
        hintStyle: kPoppins.copyWith(
            color: Color(0xff4E4446),
            fontSize: 15,
            fontWeight: FontWeight.normal),
        suffixIcon: widget.isPasswordTextField
            ? IconButton(
                icon: widget.obscureText
                    ? Icon(Icons.visibility, color: blue)
                    : Icon(Icons.visibility_off, color: blue),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
