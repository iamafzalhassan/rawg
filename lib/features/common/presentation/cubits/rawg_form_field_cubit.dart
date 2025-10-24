import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rawg_form_field_state.dart';

class RAWGFormFieldCubit extends Cubit<RAWGFormFieldState> {
  RAWGFormFieldCubit() : super(const RAWGFormFieldState());

  void toggleObscureText() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void setObscureText(bool value) {
    emit(state.copyWith(obscureText: value));
  }
}