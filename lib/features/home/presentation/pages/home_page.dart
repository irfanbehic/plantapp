import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';
import 'package:plantapp/features/home/data/datasources/home_remote_datasource.dart';
import 'package:plantapp/features/home/data/repositories/home_repository_impl.dart';
import 'package:plantapp/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:plantapp/features/home/domain/usecases/get_questions_usecase.dart';
import 'package:plantapp/features/home/presentation/bloc/home_cubit.dart';
import 'package:plantapp/features/home/presentation/bloc/home_state.dart';
import 'package:plantapp/features/home/presentation/widgets/category_card_widget.dart';
import 'package:plantapp/features/home/presentation/widgets/premium_banner_widget.dart';
import 'package:plantapp/features/home/presentation/widgets/question_card_widget.dart';
import 'package:plantapp/features/home/presentation/widgets/search_bar_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        getCategoriesUseCase: GetCategoriesUseCase(
          HomeRepositoryImpl(
            remoteDataSource: HomeRemoteDataSourceImpl(),
          ),
        ),
        getQuestionsUseCase: GetQuestionsUseCase(
          HomeRepositoryImpl(
            remoteDataSource: HomeRemoteDataSourceImpl(),
          ),
        ),
      )..loadData(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '☀️';
    if (hour < 17) return '⛅';
    return '🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/homebackground.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, plant lover!',
                              style: AppTextStyles.greetingSmall,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  _getGreeting(),
                                  style: AppTextStyles.greetingLarge,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _getGreetingEmoji(),
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const SearchBarWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: PremiumBannerWidget(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return switch (state) {
                  HomeLoading() => const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  HomeLoaded(
                    questions: final questions,
                    categories: final categories
                  ) =>
                    _HomeContentSliver(
                      questions: questions,
                      categories: categories,
                    ),
                  HomeError(message: final message) => SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.textSecondary,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              message,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<HomeCubit>().loadData(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                };
              },
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: const _NavCameraButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _HomeContentSliver extends StatelessWidget {
  final List questions;
  final List categories;

  const _HomeContentSliver({
    required this.questions,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: questions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) =>
                QuestionCardWidget(question: questions[index] as dynamic),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: categories
                    .map(
                      (cat) => SizedBox(
                        width: cardWidth,
                        height: cardWidth,
                        child: CategoryCardWidget(category: cat as dynamic),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 48),
      ]),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      color: Colors.white.withValues(alpha: 0.92),
      elevation: 0,
      notchMargin: 4,
      shape: const CircularNotchedRectangle(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: const Color(0xFF13231B).withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(svgPath: 'assets/icons/home.svg', label: 'Home', isActive: true),
                  _NavItem(svgPath: 'assets/icons/diagnose.svg', label: 'Diagnose'),
                ],
              ),
            ),
            const SizedBox(width: 66),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(svgPath: 'assets/icons/mygarden.svg', label: 'My Garden'),
                  _NavItem(svgPath: 'assets/icons/profile.svg', label: 'Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.svgPath,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? AppColors.bottomNavSelected : AppColors.bottomNavUnselected;
    return SizedBox(
      width: 74,
      height: 52,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 26,
            height: 26,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppTextStyles.navLabel.copyWith(
              color: color,
              fontSize: 11,
              letterSpacing: -0.24,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCameraButton extends StatelessWidget {
  const _NavCameraButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: GradientRotation(153.43 * 3.14159 / 180),
          colors: [Color(0xFF28AF6E), Color(0xFF2CCC80)],
          stops: [0.1667, 1.0],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.24),
          width: 4,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/identify.svg',
          width: 26,
          height: 26,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
