import '../constants/app_strings.dart';

abstract final class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.requiredField;
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return AppStrings.invalidEmail;
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppStrings.requiredField;
    if (value.length < 8) return AppStrings.passwordTooShort;
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return AppStrings.requiredField;
    if (value != password) return AppStrings.passwordsDoNotMatch;
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) return AppStrings.invalidPhone;
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.requiredField;
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.requiredField;
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }
}
