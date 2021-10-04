import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/customer.dart';
import 'package:flutter_contacts/services/notify_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CustomerService extends ChangeNotifier {
  final String _baseUrl = '192.168.0.105:8000';

  final List<Customer> customers = [];
  bool isLoading = true;
  bool isSaving = false;
  late Customer selectedCustomer;

  final storage = new FlutterSecureStorage();

  CustomerService() {
    this.loadCustomers();
  }

  List<Customer> parseCustomer(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
  }
  //Fetch Data

  Future<List<Customer>> loadCustomers() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'api/customers');
    final resp = await http.get(
      url,
      headers: <String, String>{
        'token-key': await storage.read(key: 'token') ?? ''
      },
    );
    final Map<String, dynamic> customerMap = json.decode(resp.body);
    for (var customer in customerMap["customers"]) {
      final tempCustomer = Customer.fromMap(customer);
      this.customers.add(tempCustomer);
    }

    this.isLoading = false;
    notifyListeners();

    return this.customers;
  }

  Future saveOrCreateCustomer(Customer customer) async {
    isSaving = true;
    notifyListeners();

    if (customer.id == null) {
      //saving new customer
      await this.createCustomer(customer);
    } else {
      await this.updateCustomer(customer);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<int> updateCustomer(Customer customer) async {
    final url = Uri.http(_baseUrl, 'api/customers/' + customer.id.toString());
    final resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token-key': await storage.read(key: 'token') ?? ''
        },
        body: customer.toJson());
    final decodedData = json.decode(resp.body);
    if (resp.statusCode == 400) {
      await NotifyService.showSnackBar(decodedData['msg'], Colors.red);
      return 1;
    }

    //Update customer list method
    final index =
        this.customers.indexWhere((element) => element.id == customer.id);
    await NotifyService.showSnackBar(
        "Customer successfully updated", Colors.green);

    this.customers[index] = customer;
    return customer.id!;
  }

  Future<int> createCustomer(Customer customer) async {
    final url = Uri.http(_baseUrl, 'api/customers');
    print(url);
    print(customer.toJson());
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token-key': await storage.read(key: 'token') ?? ''
        },
        body: customer.toJson());
    final decodedData = json.decode(resp.body);
    if (resp.statusCode == 400) {
      await NotifyService.showSnackBar(decodedData['msg'], Colors.red);
      return 1;
    }

    //Update customer list method
    customer.id = decodedData['id'];
    await NotifyService.showSnackBar(
        'Customer successfully created', Colors.green);
    this.customers.add(customer);
    return customer.id!;
  }

  Future<int> deleteCustomer(Customer customer) async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'api/customers/' + customer.id.toString());
    final resp = await http.delete(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token-key': await storage.read(key: 'token') ?? ''
        },
        body: customer.toJson());
    this.customers.removeWhere((element) => element.id == customer.id);

    this.isLoading = false;
    notifyListeners();

    return customer.id!;
  }
}
