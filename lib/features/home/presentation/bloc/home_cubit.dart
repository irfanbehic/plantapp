import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantapp/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:plantapp/features/home/domain/usecases/get_questions_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetQuestionsUseCase _getQuestionsUseCase;

  HomeCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetQuestionsUseCase getQuestionsUseCase,
  })  : _getCategoriesUseCase = getCategoriesUseCase,
        _getQuestionsUseCase = getQuestionsUseCase,
        super(const HomeInitial());

  Future<void> loadData() async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        _getCategoriesUseCase(),
        _getQuestionsUseCase(),
      ]);
      emit(HomeLoaded(
        categories: results[0] as dynamic,
        questions: results[1] as dynamic,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
