import 'package:flutter/material.dart';

import '../constants/index.dart';

class AppTextFormField extends StatelessWidget {
  final bool? readOnly;
  final bool? isTitled;
  final String? counterText;
  final String? Function(String?)? validate;
  final String? labelText;
  final String? hintText;
  final String? title;
  final IconData? icon;
  final Widget? suffix;
  final Widget? suffixWidget;
  final TextEditingController? controller;
  final double? top;
  final double? left;
  final double? leftTitle;
  final double? right;
  final int? maxLines;
  final int? maxLength;
  final double? titleBottom;
  final BorderSide? borderSide;
  final TextStyle? hintStyle;
  final void Function(String)? onChange;
  final bool obscureText;
  final bool? isTextFieldHeight;
  final double? textFieldHeight;
  final TextInputType? keybordType;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final Color? fillColor;
  final TextStyle? style;
  final Decoration? decoration;
  final BorderRadius? focusBorderRadius;
  final BorderRadius? enabledRadius;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? isPrefix;
  final Widget? prefix;
  final TextStyle? titleStyle;
  final Widget? prefixWithoutPadding;
  final bool? isRequired;
  final BoxConstraints? prefixConstraints;

  const AppTextFormField(
      {super.key,
      this.readOnly,
      this.labelText,
      this.hintText,
      this.icon,
      this.title,
      this.validate,
      this.controller,
      this.suffix,
      this.top,
      this.titleBottom,
      this.keybordType,
      this.maxLines,
      this.isTitled = true,
      this.left,
      this.leftTitle,
      this.right,
      this.hintStyle,
      this.onChange,
      this.isRequired = false,
      this.obscureText = false,
      this.isTextFieldHeight = false,
      this.textFieldHeight,
      this.onTap,
      this.maxLength,
      this.prefixConstraints,
      this.borderSide,
      this.onEditingComplete,
      this.autovalidateMode,
      this.fillColor,
      this.style,
      this.decoration,
      this.focusBorderRadius,
      this.enabledRadius,
      this.contentPadding,
      this.focusNode,
      this.autofocus,
      this.counterText,
      this.prefix,
      this.titleStyle,
      this.suffixWidget,
      this.prefixWithoutPadding,
      this.isPrefix = true});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(left: left ?? 0, right: right ?? 0, top: top ?? 10),
      child: Column(
        children: [
          if (isTitled == true)
            Padding(
              padding: EdgeInsets.only(
                bottom: titleBottom ?? 5,
              ),
              child: Row(
                children: [
                  Text(
                    title ?? ''.toUpperCase(),
                    style: titleStyle ??
                        latoText.get12.textColor(appColors.xff131A2E),
                  ),
                  if (isRequired == true)
                    Text(
                      "*",
                      style: latoText.get18.w700.textColor(appColors.xffF44336),
                    ),
                ],
              ),
            ),
          Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0x3FE8E8E8),
                blurRadius: 45,
                offset: Offset(15, 20),
                spreadRadius: 0,
              )
            ]),
            child: Container(

              decoration: decoration,
              child: TextFormField(
                style: style ??
                    latoText.get15.w500.textColor(const Color(0xFF3B3B3B)),
                onTap: onTap,
                keyboardType: keybordType,
                obscureText: obscureText,
                onChanged: onChange,
                maxLines: maxLines ?? 1,
                maxLength: maxLength,
                readOnly: readOnly ?? false,
                controller: controller,
                validator: validate,
                focusNode: focusNode,
                autofocus: autofocus ?? false,
                onEditingComplete: onEditingComplete,
                autovalidateMode:
                    autovalidateMode ?? AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 50,
                      minHeight: 0,
                    ),
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(
                            vertical: height * 0.02, horizontal: 20),
                    prefixIcon: prefix,
                    counterText: counterText,
                    fillColor: fillColor ?? Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: focusBorderRadius ??
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: borderSide ??
                            BorderSide(color: appColors.xff000000)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: enabledRadius ??
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: borderSide ??
                            BorderSide(color: appColors.xff000000)),
                    suffix: suffixWidget,
                    suffixIcon: suffix,
                    hintText: hintText,
                    hintStyle: hintStyle ??
                        latoText.get15.textColor(appColors.xff757575),
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: appColors.xffFFE2CB))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
