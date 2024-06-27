import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {

  final String? label;
  final String? hint;
  final String? errormsg;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextForm({Key? key, this.label, this.hint, this.errormsg, this.obscureText = false, this.onChanged, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(color: colors.primary)
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: colors.primary,
        errorText: errormsg
      ),
    );
  }
}