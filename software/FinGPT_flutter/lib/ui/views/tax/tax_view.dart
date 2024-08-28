import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'tax_viewmodel.dart';

class TaxView extends StackedView<TaxViewModel> {
  const TaxView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TaxViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predict Tax"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Total Salary'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('totalSalary', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Income from other sources'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('incomeFromOtherSources', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Contribution to NPS U/S 80CCD(2)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('npsContribution', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Exemption of leave encashment US10 (10AA)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('leaveEncashmentExemption', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Transport allowance for specially-abled persons'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('transportAllowance', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Interest on home loan taken for let-out property U/S 24(b)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('homeLoanInterest', value),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Other Deductions under new regime'),
              keyboardType: TextInputType.number,
              onChanged: (value) => viewModel.updateInput('otherDeductions', value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Prepare input data
                Map<String, dynamic> inputData = {
                  'totalSalary': viewModel.totalSalary,
                  'incomeFromOtherSources': viewModel.incomeFromOtherSources,
                  'npsContribution': viewModel.npsContribution,
                  'leaveEncashmentExemption': viewModel.leaveEncashmentExemption,
                  'transportAllowance': viewModel.transportAllowance,
                  'homeLoanInterest': viewModel.homeLoanInterest,
                  'otherDeductions': viewModel.otherDeductions,
                };

                // Call ViewModel method to get prediction
                double? prediction = await viewModel.predict(inputData);

                // Handle prediction result
                if (prediction != null) {
                  // Show predicted result
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Predicted Tax'),
                        content: Text('The predicted tax is: ${prediction.round()}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Handle error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Failed to get prediction.',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Predict Tax'),
            ),
          ],
        ),
      ),
    ),
      ),
    );
  }

  @override
  TaxViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TaxViewModel();
}
