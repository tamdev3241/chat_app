part of 'validate_form_bloc.dart';

enum FormValidStatus { initial, success, error }

class FormValidatorState extends Equatable {
  final FormValidStatus status;
  final String? emailErrorText;
  final String? passErrorText;

  const FormValidatorState({
    this.status = FormValidStatus.initial,
    this.emailErrorText,
    this.passErrorText,
  });

  @override
  List<Object?> get props => [status, emailErrorText, passErrorText];

  FormValidatorState cloneWith({
    FormValidStatus? status,
    String? emailErrorText,
    String? passErrorText,
  }) =>
      FormValidatorState(
        status: status ?? this.status,
        emailErrorText: emailErrorText,
        passErrorText: passErrorText,
      );
}
