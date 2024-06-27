part of 'register_cubit.dart';

enum FormStatus {
  invalid, valid, validating, posting
}

class RegisterState extends Equatable {

  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;

  const RegisterState({
    this.formStatus = FormStatus.invalid, 
    this.isValid = false,
    this.username = const Username.pure(), 
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  @override
  List<Object> get props => [ formStatus, isValid, username, email, password ];

  RegisterState copyWith({
    FormStatus? formStatus,
    Username? username,
    bool? isValid,
    Email? email,
    Password? password
  }) => RegisterState(
    formStatus: formStatus ?? this.formStatus, 
    username: username ?? this.username, 
    isValid: isValid ?? this.isValid, 
    email: email ?? this.email, 
    password: password ?? this.password
  );
}
