import 'package:rawg/features/auth/domain/entities/app_user.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  AppUser? call() => authRepository.getCurrentUser();
}
