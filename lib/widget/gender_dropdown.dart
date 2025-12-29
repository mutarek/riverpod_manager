

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/core/constant/app_constant.dart';
import 'package:manager/feature/home/provider/login_form_validator.dart';

class GenderDropdown extends ConsumerWidget {
  const GenderDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(genderProvider);

    return DropdownButtonFormField<String>(
      value: gender,
      decoration: const InputDecoration(
        labelText: AppStrings.gender,
        hintText: AppStrings.selectGender,
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(),
      ),
      items: AppConstants.genderOptions.map((String genderOption) {
        return DropdownMenuItem<String>(
          value: genderOption,
          child: Text(genderOption),
        );
      }).toList(),
      onChanged: (String? newValue) {
        ref.read(genderProvider.notifier).state = newValue;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }
}