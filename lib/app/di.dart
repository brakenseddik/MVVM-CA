import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvm/app/app_prefs.dart';
import 'package:mvvm/data/data_source/remote_datasource.dart';
import 'package:mvvm/data/network/app_api.dart';
import 'package:mvvm/data/network/dio_factory.dart';
import 'package:mvvm/data/network/network_info.dart';
import 'package:mvvm/data/repository/repo_implementor.dart';
import 'package:mvvm/domain/repositories/repository.dart';
import 'package:mvvm/domain/usecases/login_usecase.dart';
import 'package:mvvm/presentation/login/login_viewmodel.dart';
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

initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}







