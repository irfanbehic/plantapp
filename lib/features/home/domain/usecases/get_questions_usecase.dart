import 'package:plantapp/features/home/data/models/question_model.dart';
import 'package:plantapp/features/home/domain/repositories/home_repository.dart';

class GetQuestionsUseCase {
  final HomeRepository _repository;

  GetQuestionsUseCase(this._repository);

  Future<List<QuestionModel>> call() => _repository.getQuestions();
}
