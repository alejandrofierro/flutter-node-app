import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/customer.dart';

class CustomerFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Customer customer;

  CustomerFormProvider(this.customer);

  updateRating(double value) {
    this.customer.rating = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
