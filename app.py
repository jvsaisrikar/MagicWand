from flask import Flask, jsonify,render_template,request
from datetime import datetime
import cx_Oracle

app = Flask(__name__)

dsn = cx_Oracle.makedsn("localhost", 1521, service_name="orcl")
username = "hr"
password = "oracle"

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
        cursor.callproc('insert_data', [rat,dev,tos])
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



@app.route('/service_item', methods=['POST','GET'])
def p4():
    if request.method == 'POST':
        item_id = request.form['item_id']
        device_type = request.form['device_type']
        year = request.form['year']
        make = request.form['make']
        model = request.form['model']
        cursor = connection.cursor()
        cursor.callproc('insert_service_item', [item_id,device_type,year,make,model])
        connection.commit()    
        return "Form submitted successfully"
    return render_template('service_item.html')


@app.route('/repair', methods=['POST','GET'])
def p5():
    if request.method == 'POST':
        array_type = connection.gettype("MY_VARRAY_TYPE")
        p_repair_id = request.form['repair_id']
        p_phone_number = request.form['phone_number']
        p_machine_id = request.form['machine_id']
        p_type_of_service = request.form['type_of_service[]']
        p_parts_list = request.form.getlist('parts_list[]')

        today = datetime.today()

        date_string = today.strftime('%d-%m-%Y')
        date_object = datetime.strptime(date_string, '%d-%m-%Y')


        cursor = connection.cursor()
        p_out_name = cursor.var(cx_Oracle.STRING)
        p_out_phone_number = cursor.var(cx_Oracle.NUMBER)
        p_out_address = cursor.var(cx_Oracle.STRING)
        p_out_date_of_service = cursor.var(cx_Oracle.DATETIME)
        p_out_machine_id = cursor.var(cx_Oracle.NUMBER)
        p_out_type_of_service = cursor.var(cx_Oracle.STRING)
        p_out_service_item_covered = cursor.var(cx_Oracle.STRING)
        p_out_itemised_charges = cursor.var(cx_Oracle.STRING)
        p_out_total = cursor.var(cx_Oracle.NUMBER)

        db_array = array_type.newobject()
        for value in p_parts_list:
            db_array.append(value)

        cursor.callproc("add_repair_job", [p_repair_id, date_object, p_phone_number, p_machine_id, p_type_of_service, db_array, p_out_name, p_out_phone_number, p_out_address, p_out_date_of_service, p_out_machine_id, p_out_type_of_service, p_out_service_item_covered, p_out_itemised_charges,p_out_total])
        out_name = p_out_name.getvalue()
        out_phone_number = int(p_out_phone_number.getvalue())
        out_address = p_out_address.getvalue()
        out_date_of_service = p_out_date_of_service.getvalue()
        out_machine_id = int(p_out_machine_id.getvalue())
        out_type_of_service = p_out_type_of_service.getvalue()
        out_service_item_covered = p_out_service_item_covered.getvalue()
        out_itemised_charges = p_out_itemised_charges.getvalue()
        spl=out_itemised_charges.split(',')
        out_total=p_out_total.getvalue()
        cursor.close()
        connection.close()
        data=[ ]
        item= {
            "out_name": out_name,
            "out_phone_number": out_phone_number,
            "out_address": out_address,
            "out_date_of_service": out_date_of_service,
            "out_machine_id": out_machine_id,
            "out_type_of_service": out_type_of_service,
            "out_service_item_covered": out_service_item_covered,
            "out_itemised_charges": spl,
            "out_total":out_total
        }
        data.append(item)
        return render_template('data.html',data=data)

    return render_template('repair.html')

@app.route('/c', methods=['POST','GET'])
def p6():
    data=[]
    if request.method == 'POST':
        number = request.form['number-input']
        cursor = connection.cursor()
        users = cursor.var(cx_Oracle.CURSOR)
        cursor.callproc('display_service_contract_by_id', [number,users])
        result = users.getvalue()
        for row in result:
            item = {'id': row[0], 'start_date':row[1], 'end_date':row[2], "status":row[3],"phone":row[4]}
            data.append(item)  
        return render_template('looped_data_table.html', data=data)
    return render_template('c.html')

@app.route('/d', methods=['POST','GET'])
def p7():
    data=[]
    if request.method == 'POST':
        number = request.form['number-input']
        cursor = connection.cursor()
        users = cursor.var(cx_Oracle.CURSOR)
        cursor.callproc('display_all_service_contracts_by_customer', [number,users])
        result = users.getvalue()
        for row in result:
            item = {'id': row[0], 'start_date':row[1], 'end_date':row[2], "status":row[3],"phone":row[4]}
            data.append(item)  
        return render_template('looped_data_table.html', data=data)
    return render_template('d.html')


@app.route('/f', methods=['POST','GET'])
def p8():
    data=[]
    if request.method == 'POST':
        cursor = connection.cursor()
        users = cursor.var(cx_Oracle.CURSOR)
        cursor.callproc('display_all_active_service_contract_revenue', [users])
        result = users.getvalue()
        print(result)
        print("&&&")
        for row in result:
            row=list(row)
            item = {'year': row[0], 'month':row[1], 'active':row[2], "revenue":row[3]}
            data.append(item)   
        return render_template('looped_data_table_new.html', data=data)
    return render_template('f.html')



@app.route('/g', methods=['POST','GET'])
def p9():
    data=[]
    if request.method == 'POST':
        year = request.form['number-input-year']
        month = request.form['number-input-month']
        cursor = connection.cursor()
        total_revenue = cursor.var(cx_Oracle.NUMBER)
        cursor.callproc('get_total_repair_job_revenue_specified_month_year', [month,year, total_revenue])
        revenue = total_revenue.getvalue()
        item={
            "month":month,
            "year":year,
            "revenue":revenue
        }
        data.append(item)
        return render_template('g_data.html', data=data)
    return render_template('g.html')

@app.route('/e', methods=['POST','GET'])
def p10():
    data=[]
    if request.method == 'POST':
        rep = request.form['number-input']
        cursor = connection.cursor()
        p_name = cursor.var(cx_Oracle.STRING)
        p_phone_number = cursor.var(cx_Oracle.NUMBER)
        p_address = cursor.var(cx_Oracle.STRING)
        p_device_type = cursor.var(cx_Oracle.STRING)
        p_make = cursor.var(cx_Oracle.STRING)
        p_model = cursor.var(cx_Oracle.STRING)
        p_year = cursor.var(cx_Oracle.NUMBER)
        p_date_of_service = cursor.var(cx_Oracle.DATETIME)
        p_type_of_service = cursor.var(cx_Oracle.STRING)
        p_itemised_charges = cursor.var(cx_Oracle.STRING)
        p_total = cursor.var(cx_Oracle.NUMBER)
        cursor.callproc("display_repair_job", [rep,p_name,p_phone_number,p_address,p_device_type,p_make,p_model,p_year,p_total,p_itemised_charges,p_date_of_service,p_type_of_service])

        out_name = p_name.getvalue()
        out_phone_number = int(p_phone_number.getvalue())
        out_address = p_address.getvalue()
        out_device_type=p_device_type.getvalue()
        out_make=p_make.getvalue()
        out_model=p_model.getvalue()
        out_year=int(p_year.getvalue())
        out_date_of_service = p_date_of_service.getvalue()
        out_type_of_service = p_type_of_service.getvalue()
        out_itemised_charges = p_itemised_charges.getvalue()
        out_total=p_total.getvalue()
        spl=out_itemised_charges.split(',')

        cursor.close()
        connection.close()

        item= {
            "out_name": out_name,
            "out_phone_number": out_phone_number,
            "out_address": out_address,
            "out_device_type":out_device_type,
            "out_make":out_make,
            "out_model":out_model,
            "out_year":out_year,
            "out_date_of_service":out_date_of_service,
            "out_type_service":out_type_of_service,
            "out_itemised_charges":spl,
            "out_total":out_total

        }
        data.append(item)
        return render_template('e_data.html', data=data)
    return render_template('e.html')

@app.route('/fav', methods=['POST','GET'])
def p11():
    if request.method == 'POST':
        data=[]
        cursor = connection.cursor()
        phone_number = cursor.var(cx_Oracle.NUMBER)
        name = cursor.var(cx_Oracle.STRING)
        address = cursor.var(cx_Oracle.STRING)
        repair_count = cursor.var(cx_Oracle.NUMBER)
        cursor.callproc("max_repairs_customer", [phone_number,name,address,repair_count])

        out_name = name.getvalue()
        out_phone_number = int(phone_number.getvalue())
        out_address = address.getvalue()
        out_count= int(repair_count.getvalue())

        item={
            "out_name":out_name,
            "out_address":out_address,
            "out_phone":out_phone_number,
            "out_count":out_count
        }
        data.append(item)

        return render_template("fav_out.html",data=data)

    return render_template('fav.html')


@app.route('/expiry', methods=['POST','GET'])
def p12():
    data=[]
    if request.method == 'POST':
        number = request.form['number-input']
        cursor = connection.cursor()
        users = cursor.var(cx_Oracle.CURSOR)
        cursor.callproc('find_expiring_contracts', [number,users])
        result = users.getvalue()
        
        for row in result:
            item={"id":row[0],"phone":row[4],"ed":row[2]}
            data.append(item)
        cursor.close()
        return render_template("exp_data.html", data=data)
    return render_template('expiry.html')

@app.route('/average', methods=['POST','GET'])
def p13():
    result=0
    if request.method == 'POST':
        cursor = connection.cursor()
        users = cursor.var(cx_Oracle.NUMBER)
        cursor.callproc('get_avg_repair_bill', [users])
        result = users.getvalue()
        print(result)
        return f'The average bill size is {result}'
    return render_template("average.html")

if __name__ == '__main__':
    app.run()

