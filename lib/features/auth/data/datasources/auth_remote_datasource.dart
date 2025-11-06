import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rawg/core/network/api_result.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<User>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<ApiResult<User>> signIn({
    required String email,
    required String password,
  });

  Future<ApiResult<void>> signOut();

  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ApiResult<User>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        return const ApiFailure(message: 'Sign up failed. Please try again.');
      }

      return ApiSuccess(response.user!);
    } on AuthException catch (e) {
      return ApiFailure(message: e.message);
    } catch (e) {
      return ApiFailure(message: e.toString());
    }
  }

  @override
  Future<ApiResult<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return const ApiFailure(message: 'Sign in failed. Please try again.');
      }

      return ApiSuccess(response.user!);
    } on AuthException catch (e) {
      return ApiFailure(message: e.message);
    } catch (e) {
      return ApiFailure(message: e.toString());
    }
  }

  @override
  Future<ApiResult<void>> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      return const ApiSuccess(null);
    } on AuthException catch (e) {
      return ApiFailure(message: e.message);
    } catch (e) {
      return ApiFailure(message: e.toString());
    }
  }

  @override
  User? getCurrentUser() {
    return supabaseClient.auth.currentUser;
  }
}