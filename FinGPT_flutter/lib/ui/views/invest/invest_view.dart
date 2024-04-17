import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'invest_viewmodel.dart';

class InvestView extends StackedView<InvestViewModel> {
  const InvestView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InvestViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predict Investment"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Text("Invest"),
              TextField(
                decoration: const InputDecoration(labelText: 'Annual Income'),
                keyboardType: TextInputType.number,
                onChanged: (value) => viewModel.updateInput(value),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Prepare input data
                  Map<String, dynamic> inputData = {
                    'annual_income': viewModel.annualIncome,
                  };

                  // Call ViewModel method to get prediction
                  List<dynamic>? prediction = await viewModel.predict(inputData);

                  // Handle prediction result
                  if (prediction != null) {
                    // Show predicted result
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Predicted Investment Option(s) are'),
                          content: Text('Prediction: $prediction',
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
                child: const Text('Predict Investment'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  InvestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InvestViewModel();
}
