import 'package:flutter/material.dart';

extension StringExtension on String {
  String? validateEmpty(BuildContext context) => (isEmpty) ? 'Required field' : null;

  String? validateEmail(BuildContext context) {
    var regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return (isEmpty)
        ? 'Required field'
        : (!regex.hasMatch(this))
            ? 'Invalid email'
            : null;
  }
}
