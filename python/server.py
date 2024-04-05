import numpy as np
from flask import Flask, request, jsonify
import pickle

application = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))

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