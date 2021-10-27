import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validate_form_event.dart';
part 'validate_form_state.dart';

class FormValidatorBloc extends Bloc<FormValidatorEvent, FormValidatorState> {
  FormValidatorBloc() : super(const FormValidatorState());

  @override
  Stream<FormValidatorState> mapEventToState(FormValidatorEvent event) async* {
    if (event is CheckFormEvent) {
      if (event.email.isEmpty && event.pass.isEmpty) {
        yield state.cloneWith(
          status: FormValidStatus.error,
          emailErrorText: 'Email is not empty',
          passErrorText: 'Pass is not empty',
        );
      } else if (event.email.isEmpty) {
        yield state.cloneWith(
          status: FormValidStatus.error,
          emailErrorText: 'Email is not empty',
          passErrorText: null,
        );
      } else if (event.pass.isEmpty) {
        yield state.cloneWith(
          status: FormValidStatus.error,
          emailErrorText: null,
          passErrorText: 'Pass is not empty',
        );
      } else {
        yield state.cloneWith(
          status: FormValidStatus.success,
          emailErrorText: null,
          passErrorText: null,
        );
      }
    }
  }
}
