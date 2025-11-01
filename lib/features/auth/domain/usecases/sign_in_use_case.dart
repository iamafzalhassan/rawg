import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<ApiResult<User>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.signIn(
      email: email,
      password: password,
    );
  }
}