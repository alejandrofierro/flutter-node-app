import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/customer.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;

  const CustomerTile({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        size: 35,
      ),
      title: Text(
        customer.name,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
