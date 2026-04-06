import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState(currentPage: 0));

  void nextPage() {
    if (state.currentPage < 1) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void goToPage(int page) {
    emit(state.copyWith(currentPage: page));
  }
}
