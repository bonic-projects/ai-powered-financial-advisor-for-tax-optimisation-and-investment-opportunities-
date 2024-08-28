import 'package:fintaxai/app/app.locator.dart';
import 'package:fintaxai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  // final _dialogService = locator<DialogService>();
  // final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  void taxnavigation() {
    _navigationService.navigateTo(Routes.taxView);
  }

  void investnavigation() {
    _navigationService.navigateTo(Routes.investView);
  }

  void chatnavigation() {
    _navigationService.navigateTo(Routes.chatView);
  }
}
