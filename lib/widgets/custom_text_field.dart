import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final bool obscured;
  final bool last;
  final String? Function(String?)? validator;
  final TextEditingController textController;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.textController,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.obscured = false,
    this.last = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscured ? _passwordInvisible : widget.obscured,
        controller: widget.textController,
        validator: widget.validator,
        textInputAction: widget.last ? TextInputAction.done : TextInputAction.next,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          disabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blueGrey, width: 7),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blueGrey, width: 7),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blueGrey, width: 7),
          ),
          errorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 7),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 7),
          ),
          errorStyle: const TextStyle(color: Colors.red),
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.black),
          hintText: widget.obscured ? '************' : widget.hintText,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Theme.of(context).primaryColor,
                )
              : null,
          suffixIcon: widget.obscured
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    _passwordInvisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => setState(
                    () => _passwordInvisible = !_passwordInvisible,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
