import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final String labelText;
  final String? errorText;
  final Icon icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  const MyForm({
    super.key,
    required this.labelText,
    required this.icon,
    this.errorText,
    this.obscureText = false,
    required this.onChanged,
  });

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final FocusNode _focusNode = FocusNode();
  bool _showError = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _showError = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      obscureText: obscureText,
      onChanged: (value) {
        setState(() {
          _showError = value.isEmpty;
        });
        widget.onChanged(value);
      },
      decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: _showError ? widget.errorText : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  const BorderSide(color: Color(0xFF6BB577), width: 1.0)),
          prefixIcon: widget.icon,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null),
    );
  }
}
