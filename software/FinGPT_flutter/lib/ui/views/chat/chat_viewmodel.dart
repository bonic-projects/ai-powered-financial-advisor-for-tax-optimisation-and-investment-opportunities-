import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../services/gpt_service.dart';
import '../../../services/prediction_service.dart';

enum MessageSender { user, system }

class Message {
  final String text;
  final MessageSender sender;

  Message(this.text, this.sender);

  Map<String, dynamic> toJson() {
    return {
      'content': text,
      'role': sender == MessageSender.user ? 'user' : 'assistant',
    };
  }

  Message.fromMap(Map<String, dynamic> data)
      : text = data['content'] ?? "",
        sender =
        data['role'] == "user" ? MessageSender.user : MessageSender.system;
}

class ChatViewModel extends BaseViewModel {
  final log = getLogger('ChatViewModel  ');
  final _gptService = locator<GptService>();
  final _predictionService = locator<PredictionService>();

  List<Message> messages = [];
  List<String> questions = [
    'What is your Total Salary?',
    'Is there any Income from other sources?',
    'Contribution to NPS U/S 80CCD(2)?',
    'Exemption of leave encashment US10 (10AA)?',
    'Transport allowance for specially-abled persons?',
    'Interest on home loan taken for let-out property U/S 24(b)?',
    'Other Deductions under new regime?',
    'Annual Income?',
  ];
  int questionIndex = 0;
  TextEditingController controller = TextEditingController();

  void onModelReady() {
    //delay
    addMessage(Message(
        "Hi I am FinGPT you financial AI assistant powered with custom Tax Prediction ML models.",
        MessageSender.system));
    Future.delayed(const Duration(seconds: 2), () {
      addMessage(Message(questions[questionIndex], MessageSender.system));
      questionIndex++;
    });
  }

  void sendMessage() async {
    String text = controller.text;
    addMessage(Message(text, MessageSender.user));
    controller.clear();
    // Extract answers from messages and populate inputData
    if (messages.length < 18) {
      extractAnswers(questions[questionIndex - 1]);
      log.i(inputData);
      log.i(inputData2);
    }
    // Check if all questions are asked
    if (questionIndex < questions.length) {
      // Add a delay before asking the next question
      Future.delayed(const Duration(seconds: 1), () {
        // Display the next question after the delay
        if (questionIndex < questions.length) {
          addMessage(Message(questions[questionIndex], MessageSender.system));
          questionIndex++;
        }
      });
    } else {
      // Make function call with answers and display result
      String result = await getResult();
      addMessage(Message(result, MessageSender.system));
    }
  }

  Map<String, dynamic> inputData = {
    'totalSalary': '',
    'incomeFromOtherSources': '',
    'npsContribution': '',
    'leaveEncashmentExemption': '',
    'transportAllowance': '',
    'homeLoanInterest': '',
    'otherDeductions': '',
  };

  Map<String, dynamic> inputData2 = {
    'annual_income': '',
  };

  void extractAnswers(String question) {
    String answer = messages.first.text;
    log.i(question);
    log.i(answer);
    // String answer = text.substring(question.length).trim();
    switch (question) {
      case 'What is your Total Salary?':
        inputData['totalSalary'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Is there any Income from other sources?':
        inputData['incomeFromOtherSources'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Contribution to NPS U/S 80CCD(2)?':
        inputData['npsContribution'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Exemption of leave encashment US10 (10AA)?':
        inputData['leaveEncashmentExemption'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Transport allowance for specially-abled persons?':
        inputData['transportAllowance'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Interest on home loan taken for let-out property U/S 24(b)?':
        inputData['homeLoanInterest'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Other Deductions under new regime?':
        inputData['otherDeductions'] = double.tryParse(answer) ?? 0.0;
        break;
      case 'Annual Income?':
        inputData2['annual_income'] = double.tryParse(answer) ?? 0.0;
        break;
    }
  }

  void addMessage(Message message) {
    messages.insert(0, message); // Add new message to the beginning of the list
    notifyListeners();
  }

  Future<String> getResult() async {
    setBusy(true);
    // Make function call with answers
    log.i("Messages length: ${messages.length}");
    if (messages.length == 17) {
      addMessage(Message(
          "Please wait while we predict your tax..", MessageSender.system));
      String tax = await getTaxPrediction();
      addMessage(Message(tax, MessageSender.system));
      await Future.delayed(const Duration(seconds: 1));

      addMessage(Message(
          "Please wait while we predict your Investment opportunities..",
          MessageSender.system));
      String invest = await getInvestmentPrediction();
      addMessage(Message(invest, MessageSender.system));

      await Future.delayed(const Duration(seconds: 2));
      addMessage(Message(
          "Give me some ideas to optimise my tax?", MessageSender.user));
      return getGPT();
    } else {
      return getGPT();
    }
  }

  Future<String> getGPT() async {
    List<Map<String, dynamic>> reversedList =
    messages
        .map((e) => e.toJson())
        .toList()
        .reversed
        .toList();
    log.e(reversedList.last);
    String? answer = await _gptService.getChatResponse(reversedList);
    if (answer != null) {
      setBusy(false);
      return answer;
    } else {
      setBusy(false);
      return "API request error";
    }
  }

  Future<String> getTaxPrediction() async {
    log.i(inputData);
    // Call ViewModel method to get prediction
    double? prediction = await _predictionService.getPrediction(inputData);
    setBusy(false);
    if (prediction != null) {
      // return "Expected Tax amount is: ₹${prediction.round().abs()}";
      return "Expected Tax amount is: ₹${prediction.round()}";
    } else {
      return "Failed to get prediction.";
    }
  }

  Future<String> getInvestmentPrediction() async {
    log.i(inputData2);
    // Call ViewModel method to get prediction
    List<dynamic>? prediction =
    await _predictionService.getInvestmentPrediction(inputData2);
    setBusy(false);
    if (prediction != null) {
      String predictionString =
          prediction.join(', ') ?? ''; // Join elements with a comma and space
      return "Expected Investment opportunities are: $predictionString";
    } else {
      return "Failed to get Invest prediction.";
    }
  }
}
