import 'package:rawg/core/network/api_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepository {
  Future<ApiResult<User>> signUp({
    required String email,
    required String name,
    required String password,
  });

  Future<ApiResult<User>> signIn({
    required String email,
    required String password,
  });

  Future<ApiResult<void>> signOut();

  User? getCurrentUser();
}