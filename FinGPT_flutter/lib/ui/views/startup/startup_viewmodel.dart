import 'package:fintaxai/services/gpt_service.dart';
import 'package:stacked/stacked.dart';
import 'package:fintaxai/app/app.locator.dart';
import 'package:fintaxai/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _gptService = locator<GptService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    _gptService.initializeOpenAI();
    await Future.delayed(const Duration(seconds: 3));

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic

    _navigationService.replaceWithHomeView();
  }
}
