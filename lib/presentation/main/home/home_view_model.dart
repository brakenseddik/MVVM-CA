import 'package:mvvm/domain/usecases/home_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void start() {
    // TODO: implement start
  }
}
