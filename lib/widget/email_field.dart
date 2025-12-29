import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/feature/home/provider/login_form_validator.dart';

class EmailField extends ConsumerWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "enterEmail",
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        ref.read(emailProvider.notifier).state = value;
      },
    );
  }
}