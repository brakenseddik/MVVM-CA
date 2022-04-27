import 'dart:async';
import 'dart:ffi';

import 'package:mvvm/domain/models/home_model.dart';
import 'package:mvvm/domain/usecases/home_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';
import 'package:rxdart/subjects.dart';

class HomeViewModel extends BaseViewModel
    with HomeViwModelInputs, HomeViwModelOutputs {
  StreamController _homeStreamController = BehaviorSubject<HomeObject>();
  // StreamController _servicesStreamController = BehaviorSubject<List<BannerAd>>();
  // StreamController _storestreamController = BehaviorSubject<List<Store>>();
  // StreamController _bannersStreamController = BehaviorSubject<List<Service>>();

  HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  @override
  void dispose() {
    _homeStreamController.close();

    super.dispose();
  }

  @override
  void start() {
    _getHome();
  }

  void _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULLSCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputHome.add(homeObject);
      // inputBanners.add(homeObject.data.banners);
      // inputServices.add(homeObject.data.services);
      // inputStores.add(homeObject.data.stores);
    });
  }

  @override
  Sink get inputHome => _homeStreamController.sink;

  @override
  Stream<HomeObject> get outputHome =>
      _homeStreamController.stream.map((event) => event);
}

abstract class HomeViwModelInputs {
  Sink get inputHome;
  // Sink get inputServices;
  // Sink get inputBnners;
  // Sink get inputStores;
}

abstract class HomeViwModelOutputs {
  Stream<HomeObject> get outputHome;
  // Stream<List<Service>> get outServices;
  // Stream<List<BannerAd>> get outBanners;
  // Stream<List<Store>> get outStores;
}
