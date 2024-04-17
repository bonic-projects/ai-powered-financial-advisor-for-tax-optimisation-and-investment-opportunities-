import numpy as np
from flask import Flask, request, jsonify
import pickle

application = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))
model2 = pickle.load(open('model_invest.pkl', 'rb'))


@application.route('/invest', methods=['POST'])
def predict_investment():
    '''
    Endpoint to predict investment based on JSON data
    '''
    # Get JSON data from request body
    data = request.get_json()

    # Extract required values
    annual_income = float(data['annual_income'])

    # Prepare input features
    input_features = np.array([[annual_income]])

    # Use your model to predict
    prediction = model2.predict(input_features)

    # Define investment options based on prediction
    options = {
        0: ["Tata AIA Fortune Pro", "LIC SIIP", "PNB Metlife Mera Wealth Plan"],
        1: ["HDFC Standard Sampoorn Nivesh (11X)", "ICICI Prudential Signature", "SBI eWealth Insurance"],
        2: ["Max Life Online Savings Plan", "Bajaj Allianz Smart Wealth Goal", "Birla Sun Life Wealth Aspire Plan"],
        3: ["stock marketing", "post office investments"]
    }

    # Return investment options based on prediction
    return jsonify({'prediction': options[prediction[0]]})


@application.route('/predict', methods=['POST'])
def predict():
    '''
    Endpoint to receive input data and return prediction
    '''
    # Get input data from the POST request
    data = request.json
    
    # Convert input data to array for prediction
    features = [data[key] for key in data]
    final_features = [np.array(features)]

    # Make prediction
    prediction = model.predict(final_features)

    # Return prediction as JSON
    return jsonify({'prediction': prediction[0]})

if __name__ == "__main__":
    application.run(host='0.0.0.0', port=5000, debug=True)