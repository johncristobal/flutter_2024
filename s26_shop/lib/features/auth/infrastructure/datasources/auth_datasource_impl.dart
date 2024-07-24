import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/env.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAutStatus(String token) async {
    try {
      final response = await dio.get("/auth/check-status", 
        options: Options(
          headers: {
            "Authorization": "bearer $token"
          }
        )
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch(dioError) {
      if(dioError.response?.statusCode == 401) throw WrongCredentials();
      if(dioError.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError(message: "Something wrong happened", errorCode: 1);
    } catch (e) {
      throw CustomError(message: "Something wrong happened", errorCode: 1);
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post("/auth/login", data: {
        "email": email, "password": password
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch(dioError) {
      if(dioError.response?.statusCode == 401) throw WrongCredentials();
      if(dioError.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError(message: "Something wrong happened", errorCode: 1);
    } catch (e) {
      throw CustomError(message: "Something wrong happened", errorCode: 1);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  } 


}