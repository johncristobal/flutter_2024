import 'package:formz/formz.dart';

// Define input validation errors
enum EmailError { empty, length, validEmail }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {
  // Call super.pure to represent an unmodified form input.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Email.dirty(String value) : super.dirty(value);

  static final RegExp emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  String? get errorMsg {
    if( isValid || isPure) return null;
    if(displayError == EmailError.empty) return "Campo requerido";
    if(displayError == EmailError.length) return "Minimo 6 caracteres";
    if(displayError == EmailError.validEmail) return "Email invalido";
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;
    if (value.length < 6) return EmailError.length;
    if(!Email.emailReg.hasMatch(value)) return EmailError.validEmail;
    return null;
  }
}