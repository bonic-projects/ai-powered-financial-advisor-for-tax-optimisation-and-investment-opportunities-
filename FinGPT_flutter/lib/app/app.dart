import 'package:fintaxai/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:fintaxai/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:fintaxai/ui/views/home/home_view.dart';
import 'package:fintaxai/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:fintaxai/ui/views/tax/tax_view.dart';
import 'package:fintaxai/ui/views/chat/chat_view.dart';
import 'package:fintaxai/ui/views/invest/invest_view.dart';
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
)
class App {}
