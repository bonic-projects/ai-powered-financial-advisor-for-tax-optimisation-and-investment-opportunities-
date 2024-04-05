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
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Invest"),
      ),
    );
  }

  @override
  InvestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      InvestViewModel();
}
