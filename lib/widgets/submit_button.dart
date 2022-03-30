import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: Align(
          alignment: Alignment.center,
          child: isLoading ? _loader() : Text(text),
        ),
      ),
    );
  }

  Widget _loader() {
    return Center(
      child: SpinKitCircle(
        key: const Key('spinkitLoader'),
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
