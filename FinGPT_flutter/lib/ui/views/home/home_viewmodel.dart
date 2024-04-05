import 'package:fintaxai/app/app.bottomsheets.dart';
import 'package:fintaxai/app/app.dialogs.dart';
import 'package:fintaxai/app/app.locator.dart';
import 'package:fintaxai/app/app.router.dart';
import 'package:fintaxai/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  

  void taxnavigation (){
   _navigationService.navigateTo(Routes.taxView); 
  }
}
