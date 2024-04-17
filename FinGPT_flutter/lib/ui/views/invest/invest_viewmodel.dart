import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/prediction_service.dart';

class InvestViewModel extends BaseViewModel {
  final _predictionService = locator<PredictionService>();

  double? _annualIncome;
  double? get annualIncome => _annualIncome;


  void updateInput(String value) {
        _annualIncome = double.tryParse(value) ?? 0.0;
  }


  Future<List<dynamic>?> predict(Map<String, dynamic> inputData){
    return _predictionService.getInvestmentPrediction(inputData);
  }
}
