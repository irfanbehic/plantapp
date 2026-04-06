import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:plantapp/core/network/api_endpoints.dart';
import 'package:plantapp/core/network/dio_client.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<QuestionModel>> getQuestions();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? DioClient.instance;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get(ApiEndpoints.getCategories);
    
    final dynamic decodedResponse = response.data is String
        ? jsonDecode(response.data) 
        : response.data;

    final data = decodedResponse['data'] as List<dynamic>;
    return data.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final response = await _dio.get(ApiEndpoints.getQuestions);
    
    final dynamic decodedData = response.data is String
        ? jsonDecode(response.data) 
        : response.data;

    final data = decodedData as List<dynamic>;
    return data.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }
}