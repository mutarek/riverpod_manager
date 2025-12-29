import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/core/constant/app_constant.dart';
import 'package:manager/feature/home/provider/login_form_validator.dart';
import 'package:manager/widget/email_field.dart';
import 'package:manager/widget/gender_dropdown.dart';
import 'package:manager/widget/loading_button.dart';
import 'package:manager/widget/password_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _handleLogin(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final gender = ref.read(genderProvider);
    final rememberMe = ref.read(rememberMeProvider);

    if (email.isEmpty || ! email.contains('@')) {
      _showError(context, AppStrings.invalidEmail);
      return;
    }

    if (password.isEmpty || password.length < 6) {
      _showError(context, AppStrings.passwordTooShort);
      return;
    }

    if (gender == null || gender.isEmpty) {
      _showError(context, AppStrings.selectGenderError);
      return;
    }

    ref.read(authProvider.notifier).login(
      email: email,
      password:  password,
      gender: gender,
      rememberMe: rememberMe,
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final textList = ref.watch(textListProvider);
    final uidProvider = ref.watch(uuidProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final newUuid = uidProvider.v4();
          ref.read(textListProvider.notifier).state = [...textList, newUuid];
          debugPrint(newUuid);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: textList.map((text) => Text(text)).toList(),
              ),
              const EmailField(),
              const SizedBox(height: 16),
              const PasswordField(),
              const SizedBox(height: 16),
              GenderDropdown(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: ref.watch(rememberMeProvider),
                    onChanged: (value) {
                      ref.read(rememberMeProvider.notifier).state = value!;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(rememberMeProvider.notifier).state = !ref.read(
                        rememberMeProvider,
                      );
                    },
                    child: Text("Remember Me"),
                  ),
                ],
              ),
              LoadingButton(
                onPressed:  () => _handleLogin(context, ref),
                text: AppStrings.login,
                isLoading: authState.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
