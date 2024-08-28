import 'package:fintaxai/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:fintaxai/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:fintaxai/ui/views/home/home_view.dart';
import 'package:fintaxai/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fintaxai/ui/views/tax/tax_view.dart';
import 'package:fintaxai/ui/views/chat/chat_view.dart';
import 'package:fintaxai/ui/views/invest/invest_view.dart';
import 'package:fintaxai/services/prediction_service.dart';
import 'package:fintaxai/services/gpt_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: TaxView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: InvestView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PredictionService),
    LazySingleton(classType: GptService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger()
)
class App {}
