import 'package:flutter/material.dart';
//NOT CURRENTLY USED IN THE APP
// CAN BE USED TO CREATE A CLASS WITH REQUIRED ATTRIBUTES OF PASSWORD THAT CAN BE CALLED ANYWHERE
class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.fieldKey,
    required this.maxLength,
    required this.hintText,
    required this.labelText,
    required this.helperText,
    required this.onSaved,
    required this.validator,
    required this.onFieldSubmitted,
  });

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: widget.maxLength ?? 8,  // if not provided by the user, then it is 8
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
