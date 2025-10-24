part of 'rawg_form_field_cubit.dart';

class RAWGFormFieldState extends Equatable {
  final bool obscureText;

  const RAWGFormFieldState({this.obscureText = true});

  RAWGFormFieldState copyWith({bool? obscureText}) {
    return RAWGFormFieldState(obscureText: obscureText ?? this.obscureText);
  }

  @override
  List<Object?> get props => [obscureText];

  @override
  bool get stringify => true;
}