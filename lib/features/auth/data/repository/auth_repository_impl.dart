import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:rawg/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<User>> signUp({required String email, required String name, required String password}) async => await remoteDataSource.signUp(email: email, name: name, password: password);

  @override
  Future<ApiResult<User>> signIn({required String email, required String password}) async => await remoteDataSource.signIn(email: email, password: password);

  @override
  Future<ApiResult<void>> signOut() async => await remoteDataSource.signOut();

  @override
  User? getCurrentUser() => remoteDataSource.getCurrentUser();
}
