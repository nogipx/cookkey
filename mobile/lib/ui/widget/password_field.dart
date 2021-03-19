import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final bool forceObscure;
  final TextEditingController controller;
  final String obscuringCharacter;
  final InputDecoration decoration;

  // static get InputDecoration

  const PasswordInputField({
    Key key,
    this.forceObscure,
    this.controller,
    this.decoration,
    this.obscuringCharacter = "*",
  }) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final _accentColor = Theme.of(context).accentColor;
    final _disabledColor = Theme.of(context).disabledColor;
    final _enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: .5, color: _disabledColor),
    );
    final _focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: _accentColor),
    );

    final _decoration = widget.decoration.copyWith(
      focusColor: _accentColor,
      hoverColor: _accentColor,
      focusedBorder: _focusedBorder,
      disabledBorder: _enabledBorder,
      enabledBorder: _enabledBorder,
    );

    final _obscureText = widget.forceObscure ?? _isObscured;

    return TextFormField(
      obscureText: _obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      controller: widget.controller,
      decoration: _decoration.copyWith(
        suffixIcon: Visibility(
          visible: widget.forceObscure == null,
          child: IconButton(
            icon: _obscureText
                ? Icon(Icons.visibility_off, color: _disabledColor)
                : Icon(Icons.visibility, color: Colors.black87),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
        ),
      ),
    );
  }
}
