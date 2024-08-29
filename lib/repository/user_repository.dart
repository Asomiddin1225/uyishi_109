import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio = Dio();

  Future<String> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'http://recipe.flutterwithakmaljon.uz/api/register',
        data: {
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        // Serverdan kelayotgan xatolik xabarini olish
        if (response.data['message'] != null) {
          throw Exception('Failed to register: ${response.data['message']}');
        } else {
          throw Exception('Failed to register: Unknown error');
        }
      }
    } catch (e) {
      // DioError uchun maxsus holat
      if (e is DioError) {
        if (e.response != null) {
          throw Exception('Failed to register: ${e.response!.data['message'] ?? 'Unknown error'}');
        } else {
          throw Exception('Failed to register: No internet connection');
        }
      } else {
        throw Exception('Failed to register: $e');
      }
    }
  }
}