import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rawg/features/auth/domain/entities/app_user.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  ApiResult<AppUser> toAppUserResult(ApiResult<User> result) {
    if (result case ApiSuccess<User>(:final data)) return ApiSuccess(toAppUser(data));
    if (result case ApiFailure<User>(:final dioException, :final message, :final statusCode)) return ApiFailure(dioException: dioException, message: message, statusCode: statusCode);
    return const ApiFailure(message: 'Unexpected authentication result.');
  }

  AppUser toAppUser(User user) => AppUser(email: user.email, id: user.id);

  @override
  Future<ApiResult<AppUser>> signUp({required String email, required String name, required String password}) async => toAppUserResult(await remoteDataSource.signUp(email: email, name: name, password: password));

  @override
  Future<ApiResult<AppUser>> signIn({required String email, required String password}) async => toAppUserResult(await remoteDataSource.signIn(email: email, password: password));

  @override
  Future<ApiResult<void>> signOut() async => await remoteDataSource.signOut();

  @override
  AppUser? getCurrentUser() {
    final user = remoteDataSource.getCurrentUser();
    return user == null ? null : toAppUser(user);
  }
}
