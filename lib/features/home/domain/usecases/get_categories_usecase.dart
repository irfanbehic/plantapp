import 'package:plantapp/features/home/data/models/category_model.dart';
import 'package:plantapp/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<CategoryModel>> call() => _repository.getCategories();
}
