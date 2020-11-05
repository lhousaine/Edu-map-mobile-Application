import 'package:EduMap/features/users/presentation/pages/register_page.dart';

class InputValidator {
  static validateUsername(String value) {
    if (value.startsWith(new RegExp(r'[0-9].*'))) {
      return "Username shouldn't start with a number.";
    } else if (!(value.length > 5) && value.isNotEmpty) {
      return "Username should contains more then 5 character.";
    }
    return null;
  }

  static validatePassword(String value) {
    return null;
  }

  static validateEmptyField(String value) {
    if (value.isEmpty || value.length == 0) {
      return "Champ obligatoire*";
    }
    return null;
  }

  static bool verifyAllRequiredFields(RegisterPageParams registerParams) =>
      (registerParams.usernameController.text.isNotEmpty &&
          registerParams.firstNameController.text.isNotEmpty &&
          registerParams.lastNameController.text.isNotEmpty &&
          registerParams.birthdayController.text.isNotEmpty &&
          registerParams.emailController.text.isNotEmpty &&
          registerParams.passwordController.text.isNotEmpty &&
          registerParams.confirmPasswordController.text.isNotEmpty &&
          registerParams.selectedCity.isNotEmpty &&
          registerParams.selectedLevel.isNotEmpty &&
          registerParams.selectedSpeciality.isNotEmpty);
}
