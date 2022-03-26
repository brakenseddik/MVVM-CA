import 'package:flutter/material.dart';
import 'package:mvvm/app/di.dart';
import 'package:mvvm/presentation/forgot_password/forgot_password_view.dart';
import 'package:mvvm/presentation/login/login_view.dart';
import 'package:mvvm/presentation/login/login_viewmodel.dart';
import 'package:mvvm/presentation/main/main_screen.dart';
import 'package:mvvm/presentation/onboarding/onboarding_view.dart';
import 'package:mvvm/presentation/register/register_screen.dart';
import 'package:mvvm/presentation/resources/strings_manager.dart';
import 'package:mvvm/presentation/splash/splash_screen.dart';
import 'package:mvvm/presentation/store_details/store_details_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String mainRoute = '/main';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return undefinedRoure();
    }
  }

  static Route<dynamic> undefinedRoure() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
