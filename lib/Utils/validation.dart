import 'package:flutter/cupertino.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:phone_number/phone_number.dart';

class Validations {
  static String? validateUsername(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    final RegExp nameExp = new RegExp(r'^[A-Za-z0-9_-]+$');
    if (!nameExp.hasMatch(value))
      return S.of(context).nameRegExValidation;
    return null;
  }

  static String? emptyValidation(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    return null;
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return S.of(context).emailRequired;
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value))
      return S.of(context).invalidEmail;
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    if(value.length < 6)
      return S.of(context).passwordShouldBeAtLeast6Letters;
    return null;
  }

  static String? validateConfirmPassword(String? value, String password,  BuildContext context) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    if(value != password)
      return S.of(context).passwordDoesNotMatch;
    return null;
  }

  static Future<String?> validatePhone(String? value, BuildContext context, String countryCode) async {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    PhoneNumberUtil plugin = PhoneNumberUtil();
    try {
      bool isValid = await plugin.validate(value, countryCode);
      if (isValid) return null;
    } catch (e) {
      return S.of(context).invalidPhone;
    }
    return S.of(context).invalidPhone;
  }

  static String? noValidation(String? value) {
    return null;
  }
}
