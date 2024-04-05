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
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Tax page"
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
