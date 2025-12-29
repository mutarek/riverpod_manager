import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/feature/home/provider/login_form_validator.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscurePassword = ref.watch(passwordVisibilityProvider);

    return TextField(
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText:  "Password",
        hintText: "Enter Password",
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            ref.read(passwordVisibilityProvider.notifier).state =
            !obscurePassword;
          },
        ),
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        ref.read(passwordProvider.notifier).state = value;
      },
    );
  }
}