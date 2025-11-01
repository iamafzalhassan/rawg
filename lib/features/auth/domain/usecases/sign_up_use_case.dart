import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<ApiResult<User>> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authRepository.signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}