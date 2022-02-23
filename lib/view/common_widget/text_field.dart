import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utility/theme.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final String? keys;

  const TextFormFieldWidget({
    required this.hintText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.prefixIcon,
    this.keys,
  });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primaryColor,
      ),
      child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
              height: 44,
              child: TextFormField(
                key: ValueKey(widget.keys),
                cursorColor: primaryColor,
                obscureText: widget.obscureText!,
                keyboardType: widget.textInputType,
                textInputAction: widget.actionKeyboard,
                focusNode: widget.focusNode,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                ),
                initialValue: widget.defaultText,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  hintText: widget.hintText,
                  suffixIcon: widget.suffixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(0.0)),
                    borderSide:
                    BorderSide(color: blackColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(0.0)),
                    borderSide:
                    BorderSide(color: blackColor, width: 1),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: HexColor("#383838"),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(
                      top: 12,
                      bottom: bottomPaddingToError,
                      left: 8.0,
                      right: 8.0),
                  isDense: true,
                  errorStyle: TextStyle(fontSize: 9, height: 0),

                  errorBorder:const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(0.0)),
                    borderSide:
                    BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(0.0)),
                    borderSide:
                    BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                controller: widget.controller,
                validator: (value) {
                  if (widget.functionValidate != null) {
                    String resultValidate = widget.functionValidate!(
                        value, widget.parametersValidate);
                    if (resultValidate != null) {
                      return resultValidate;
                    }
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (widget.onSubmitField != null) widget.onSubmitField!();
                },
                onTap: () {
                  if (widget.onFieldTap != null) widget.onFieldTap!();
                },
              ))),
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}
String? nameValidation(String value, String messageError) {
  if (value.length < 3) {
    return messageError;
  }
  return null;
}
String? phoneValidation(String value, String messageError) {
  if (value.length != 10) {
    return messageError;
  }
  return null;
}
String? conPasswordValidation(String value, String messageError) {
  if (value.toString() != messageError.toString()) {
    return "Mismatch the password!";
  }
  return null;
}

String? passwordValidation(String value, String messageError) {
  bool emailValid = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value);
  if (!emailValid || !value.isNotEmpty ) {
    return 'Enter a valid password!';
  }
  return null;
}
String? emailValidation(String value, String messageError) {
  bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (!emailValid) {
    return messageError;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
