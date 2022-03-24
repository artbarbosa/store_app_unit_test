import 'package:dio/dio.dart';
import 'package:store_app_unit_test/app/modules/login/model/user_model.dart';
import 'package:store_app_unit_test/app/modules/login/repository/login_repository_interface.dart';

import '../../../core/services/remote/http_client_service.dart';
import '../errors/login_errors.dart';

class LoginRepositoryImp extends ILoginRepository {
  final IHttpService httpService;

  LoginRepositoryImp({required this.httpService});

  @override
  Future<String> postAuthWithUsernameAndPassword(
      String username, String password) async {
    try {
      final response = await httpService.post('path',
          queryParameters: {"username": username, "password": password});
      return response.data['token'] as String;
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw LoginNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw LoginNoInternetConnection();
      } else {
        throw LoginError(
          stackTrace: s,
          label: 'LoginRepositoryImp - postLoginWithUsernameAndPassword',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }

  @override
  Future<UserModel> getLoginWithUsernameAndPassword() async {
    try {
      final response = await httpService.get('');
      return UserModel.fromJson(response.data);
    } on DioError catch (e, s) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw LoginNoInternetConnection();
      } else if (e.type == DioErrorType.other) {
        throw LoginNoInternetConnection();
      } else {
        throw LoginError(
          stackTrace: s,
          label: 'LoginRepositoryImp - postLoginWithUsernameAndPassword',
          exception: e.error,
          errorMessage: e.message,
        );
      }
    }
  }
}
