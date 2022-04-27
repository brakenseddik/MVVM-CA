import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm/app/app_prefs.dart';
import 'package:mvvm/data/data_source/remote_datasource.dart';
import 'package:mvvm/data/network/app_api.dart';
import 'package:mvvm/data/network/dio_factory.dart';
import 'package:mvvm/data/network/network_info.dart';
import 'package:mvvm/data/repository/repo_implementor.dart';
import 'package:mvvm/domain/repositories/repository.dart';
import 'package:mvvm/domain/usecases/forgot_usecase.dart';
import 'package:mvvm/domain/usecases/home_usecase.dart';
import 'package:mvvm/domain/usecases/login_usecase.dart';
import 'package:mvvm/domain/usecases/register_usecase.dart';
import 'package:mvvm/presentation/forgot_password/forgot_password_viemodel.dart';
import 'package:mvvm/presentation/login/login_viewmodel.dart';
import 'package:mvvm/presentation/main/home/home_view_model.dart';
import 'package:mvvm/presentation/register/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementor(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementor(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementor(instance(), instance()));
}

initForgotModule() {
  if (!GetIt.I.isRegistered<ForgotUseCase>()) {
    instance.registerFactory<ForgotUseCase>(() => ForgotUseCase(instance()));
    instance.registerFactory<ForgotPassViewModel>(
        () => ForgotPassViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}
