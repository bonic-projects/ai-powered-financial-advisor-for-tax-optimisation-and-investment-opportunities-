import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle

application = Flask(__name__) #Initialize the flask App
model = pickle.load(open('model_invest.pkl', 'rb'))

@application.route('/')
def home():
    return render_template('index _invest.html')

@application.route('/predict', methods=['POST'])
def predict():
    '''
    For rendering results on HTML GUI
    '''
    int_features = [float(x) for x in request.form.values()]  # Convert form values to float
    final_features = np.array(int_features).reshape(1, -1)  # Reshape to 2D array
    prediction = model.predict(final_features)

    pred = prediction[0]
    list0 = ["Tata AIA Fortune Pro", "LIC SIIP", "PNB Metlife Mera Wealth Plan"]
    list1 = ["HDFC Standard Sampoorn Nivesh (11X)", "ICICI Prudential Signature", "SBI eWealth Insurance"]
    list2 = ["Max Life Online Savings Plan", "Bajaj Allianz Smart Wealth Goal", "Birla Sun Life Wealth Aspire Plan"]
    listm=["stock marketing","post office investments"]

    if pred == 0:
        return render_template('result _invest.html', output_list=list0)
    elif pred == 1:
        return render_template('result _invest.html', output_list=list1)
    elif pred == 2:
        return render_template('result _invest.html', output_list=list2)
    else:
        return render_template('result _invest.html', output_list=listm)


if __name__ == "__main__":
    application.run(debug=True)
