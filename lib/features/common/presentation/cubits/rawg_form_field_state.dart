part of 'rawg_form_field_cubit.dart';

class RAWGFormFieldState extends Equatable {
  final bool obscureText;

  const RAWGFormFieldState({this.obscureText = true});

  RAWGFormFieldState copyWith({bool? obscureText}) => RAWGFormFieldState(obscureText: obscureText ?? this.obscureText);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [obscureText];
}
