import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plantapp/features/home/data/models/category_model.dart';
import 'package:plantapp/features/home/data/models/question_model.dart';
import 'package:plantapp/features/home/domain/repositories/home_repository.dart';
import 'package:plantapp/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:plantapp/features/home/domain/usecases/get_questions_usecase.dart';
import 'package:plantapp/features/home/presentation/bloc/home_cubit.dart';
import 'package:plantapp/features/home/presentation/bloc/home_state.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockGetQuestionsUseCase extends Mock implements GetQuestionsUseCase {}

void main() {
  late MockGetCategoriesUseCase mockGetCategories;
  late MockGetQuestionsUseCase mockGetQuestions;

  final tCategories = [
    const CategoryModel(id: 1, name: 'succulents', title: 'Succulents', rank: 1),
    const CategoryModel(id: 2, name: 'ferns', title: 'Ferns', rank: 2),
  ];

  final tQuestions = [
    const QuestionModel(
      id: 1,
      title: 'How to water?',
      subtitle: 'Learn watering basics',
      imageUri: 'https://example.com/img.jpg',
      uri: 'https://example.com/q1',
      order: 1,
    ),
  ];

  setUp(() {
    mockGetCategories = MockGetCategoriesUseCase();
    mockGetQuestions = MockGetQuestionsUseCase();
  });

  HomeCubit buildCubit() => HomeCubit(
        getCategoriesUseCase: mockGetCategories,
        getQuestionsUseCase: mockGetQuestions,
      );

  group('HomeCubit', () {
    test('initial state is HomeInitial', () {
      expect(buildCubit().state, isA<HomeInitial>());
    });

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when loadData succeeds',
      build: buildCubit,
      setUp: () {
        when(() => mockGetCategories()).thenAnswer((_) async => tCategories);
        when(() => mockGetQuestions()).thenAnswer((_) async => tQuestions);
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeLoaded>()
            .having((s) => s.categories, 'categories', tCategories)
            .having((s) => s.questions, 'questions', tQuestions),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when getCategories throws',
      build: buildCubit,
      setUp: () {
        when(() => mockGetCategories()).thenThrow(Exception('network error'));
        when(() => mockGetQuestions()).thenAnswer((_) async => tQuestions);
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeError] when getQuestions throws',
      build: buildCubit,
      setUp: () {
        when(() => mockGetCategories()).thenAnswer((_) async => tCategories);
        when(() => mockGetQuestions()).thenThrow(Exception('timeout'));
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeError>(),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'HomeLoaded contains correct categories and questions counts',
      build: buildCubit,
      setUp: () {
        when(() => mockGetCategories()).thenAnswer((_) async => tCategories);
        when(() => mockGetQuestions()).thenAnswer((_) async => tQuestions);
      },
      act: (cubit) => cubit.loadData(),
      verify: (cubit) {
        final state = cubit.state as HomeLoaded;
        expect(state.categories.length, 2);
        expect(state.questions.length, 1);
      },
    );
  });
}
