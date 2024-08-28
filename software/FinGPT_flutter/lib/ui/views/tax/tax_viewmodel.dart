import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/prediction_service.dart';

class TaxViewModel extends BaseViewModel {
  final _predictionService = locator<PredictionService>();

  double? _totalSalary;
  double? _incomeFromOtherSources;
  double? _npsContribution;
  double? _leaveEncashmentExemption;
  double? _transportAllowance;
  double? _homeLoanInterest;
  double? _otherDeductions;

  double? get totalSalary => _totalSalary;
  double? get incomeFromOtherSources => _incomeFromOtherSources;
  double? get npsContribution => _npsContribution;
  double? get leaveEncashmentExemption => _leaveEncashmentExemption;
  double? get transportAllowance => _transportAllowance;
  double? get homeLoanInterest => _homeLoanInterest;
  double? get otherDeductions => _otherDeductions;

  void updateInput(String field, String value) {
    switch (field) {
      case 'totalSalary':
        _totalSalary = double.tryParse(value) ?? 0.0;
        break;
      case 'incomeFromOtherSources':
        _incomeFromOtherSources = double.tryParse(value) ?? 0.0;
        break;
      case 'npsContribution':
        _npsContribution = double.tryParse(value) ?? 0.0;
        break;
      case 'leaveEncashmentExemption':
        _leaveEncashmentExemption = double.tryParse(value) ?? 0.0;
        break;
      case 'transportAllowance':
        _transportAllowance = double.tryParse(value) ?? 0.0;
        break;
      case 'homeLoanInterest':
        _homeLoanInterest = double.tryParse(value) ?? 0.0;
        break;
      case 'otherDeductions':
        _otherDeductions = double.tryParse(value) ?? 0.0;
        break;
    }
  }



  Future<double?> predict(Map<String, dynamic> inputData){
    return _predictionService.getPrediction(inputData);
  }
}
