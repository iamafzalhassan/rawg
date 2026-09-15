import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/domain/entities/app_user.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<ApiResult<AppUser>> call({required String email, required String password}) async => await authRepository.signIn(email: email, password: password);
}
