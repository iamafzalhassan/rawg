import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<ApiResult<void>> call() async {
    return await authRepository.signOut();
  }
}