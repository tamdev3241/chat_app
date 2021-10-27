part of 'validate_form_bloc.dart';

abstract class FormValidatorEvent {}

class CheckFormEvent extends FormValidatorEvent {
  final String email;
  final String pass;
  CheckFormEvent(this.email, this.pass);
}
