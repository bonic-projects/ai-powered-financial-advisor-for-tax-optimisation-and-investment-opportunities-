import 'dart:convert';

import 'package:fintaxai/app/app.logger.dart';
import 'package:http/http.dart' as http;

class PredictionService {
  final log = getLogger('PredictionService');

  String _ip = "192.168.29.207";

  String get ipAddress => _ip;

  Future<double?> getPrediction(Map<String, dynamic> inputData) async {
    // Replace 'YOUR_SERVER_URL' with the URL of your Flask server
    String url = 'http://$ipAddress:5000/predict';

    try {
      // Make POST request to server
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputData),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response and return prediction
        Map<String, dynamic> data = jsonDecode(response.body);
        log.i(data['prediction']);
        return data['prediction'];
      } else {
        // Handle errors
        log.e('Failed to get prediction: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      log.e('Exception occured: $e');
      return null;
    }
  }

  Future<List<dynamic>?> getInvestmentPrediction(
      Map<String, dynamic> inputData) async {
    // Replace 'YOUR_SERVER_URL' with the URL of your Flask server
    String url = 'http://$ipAddress:5000/invest';

    try {
      // Make POST request to server
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputData),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response and return prediction
        Map<String, dynamic> data = jsonDecode(response.body);
        log.i(data['prediction']);
        return data['prediction'];
      } else {
        // Handle errors
        log.e('Failed to get prediction: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      log.e('Exception occured: $e');
      return null;
    }
  }
}
