import 'package:plantapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:plantapp/features/home/data/models/category_model.dart';
import 'package:plantapp/features/home/data/models/question_model.dart';
import 'package:plantapp/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<CategoryModel>> getCategories() {
    return _remoteDataSource.getCategories();
  }

  @override
  Future<List<QuestionModel>> getQuestions() {
    return _remoteDataSource.getQuestions();
  }
}
