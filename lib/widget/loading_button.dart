import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback?  onPressed;
  final String text;
  final bool isLoading;

  const LoadingButton({
    super.key,
    required this. onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed:  isLoading ? null : onPressed,
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}