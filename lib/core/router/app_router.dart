import 'package:auto_route/auto_route.dart';
import 'package:plantapp/features/home/presentation/pages/home_page.dart';
import 'package:plantapp/features/onboarding/presentation/pages/get_started_page.dart';
import 'package:plantapp/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:plantapp/features/onboarding/presentation/pages/paywall_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: GetStartedRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: PaywallRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
