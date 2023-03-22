from flask import Flask, jsonify,render_template,request
from datetime import datetime
import cx_Oracle

app = Flask(__name__)

# Oracle database credentials
dsn = cx_Oracle.makedsn("localhost", 1521, service_name="orcl")
username = "hr"
password = "oracle"

# # Connect to the Oracle database
connection = cx_Oracle.connect(username, password, dsn)
@app.route('/', methods=['POST','GET'])
def index():
    return render_template('index.html')

@app.route('/customer', methods=['POST','GET'])
def p1():
    if request.method == 'POST':
        dev = request.form['name']
        tos = request.form['address']
        rat = request.form['number']
        cursor = connection.cursor()
        cursor.callproc('insert_data', [dev, tos, rat])
        connection.commit()
        return f'Thank you for submitting the form, {dev}!'
    return render_template('customer.html')
@app.route('/service', methods=['POST','GET'])
def p2():
    if request.method == 'POST':
        contract_id = request.form['contract_id']
        start_date = request.form['start_date']
        start_formatted_date = datetime.strptime(start_date, '%Y-%m-%d').strftime('%d-%m-%Y')
        start_formatted_date = datetime.strptime(start_formatted_date, '%d-%m-%Y').date()
        end_date = request.form['end_date']
        end_formatted_date = datetime.strptime(end_date, '%Y-%m-%d').strftime('%d-%m-%Y')
        end_formatted_date = datetime.strptime(end_formatted_date, '%d-%m-%Y').date()
        status_bool = request.form['status']
        phone_number = request.form['phone_number']
        cursor = connection.cursor()
        cursor.callproc('service_contract_data', [contract_id,start_formatted_date,end_formatted_date,status_bool,phone_number])
        connection.commit()
        return f'Thank you for submitting the form, {contract_id} {start_formatted_date} {end_formatted_date} {status_bool} {phone_number}!'
    return render_template('service.html')

@app.route('/contract_delete', methods=['POST','GET'])
def p3():
    if request.method == 'POST':
        contract_id = request.form['contract_id']
        phone_number = request.form['phone_number']
        cursor = connection.cursor()
        cursor.callproc('delete_contract', [contract_id,phone_number])
        connection.commit()
        return f'Thanks! Contract Terminated'
    return render_template('contract_delete.html')




# def p4():
#     if request.method == 'POST':
#         dev = request.form['name']
#         tos = request.form['address']
#         rat = request.form['number']
#         cursor = connection.cursor()
#         cursor.callproc('insert_data', [dev, tos, rat])
#         connection.commit()
#         return f'Thank you for submitting the form, {dev}!'
#     return render_template('index.html')

# Run the Flask app
if __name__ == '__main__':
    app.run()
