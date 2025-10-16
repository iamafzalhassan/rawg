import 'package:dio/dio.dart';
import 'package:rawg/core/constants/api_constants.dart';
import 'package:rawg/core/errors/exceptions.dart';
import 'package:rawg/core/network/api_request.dart';
import 'package:rawg/core/network/api_result.dart';
import 'package:rawg/features/dashboard/data/models/remote/game_model.dart';
import 'package:rawg/features/dashboard/data/models/remote/game_overview_model.dart';

abstract interface class DashboardRemoteDataSource {
  Future<ApiResult<List<GameModel>>> getGames({
    int page = 1,
    int pageSize = ApiConstants.pageSize,
    String? ordering,
    String? platforms,
  });

  Future<ApiResult<GameOverviewModel>> getGameOverview(int id);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiRequest apiRequest;

  DashboardRemoteDataSourceImpl(this.apiRequest);

  @override
  Future<ApiResult<List<GameModel>>> getGames({
    int page = 1,
    int pageSize = ApiConstants.pageSize,
    String? ordering,
    String? platforms,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
    };

    if (ordering != null && ordering.isNotEmpty) {
      queryParameters['ordering'] = ordering;
    }

    if (platforms != null && platforms.isNotEmpty) {
      queryParameters['platforms'] = platforms;
    }

    final response = await apiRequest.get(
      ApiConstants.games,
      queryParameters: queryParameters,
    );

    final List<GameModel> games = (response.data['results'] as List).map((json) => GameModel.fromJson(json)).toList();

    return ApiSuccess(games);
  }

  @override
  Future<ApiResult<GameOverviewModel>> getGameOverview(int id) async {
    try {
      final response = await apiRequest.get('${ApiConstants.games}/$id');

      return ApiSuccess(GameOverviewModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiFailure(
        message: Exceptions.handleError(e),
        statusCode: e.response?.statusCode,
        dioException: e,
      );
    } catch (e) {
      return ApiFailure(message: e.toString());
    }
  }
}