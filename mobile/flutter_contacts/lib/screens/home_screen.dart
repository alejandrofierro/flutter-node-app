import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/customer.dart';
import 'package:flutter_contacts/screens/screens.dart';
import 'package:flutter_contacts/services/customer_service.dart';
import 'package:flutter_contacts/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customerService = Provider.of<CustomerService>(context);

    if (customerService.isLoading) return LoadingScreen();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customer'),
        ),
        body: ListView.builder(
            itemCount: customerService.customers.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  customerService.selectedCustomer =
                      customerService.customers[index].copy();
                  Navigator.pushNamed(context, '/customer');
                },
                child: Column(children: [
                  CustomerTile(customer: customerService.customers[index]),
                  Divider()
                ]))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            customerService.selectedCustomer =
                new Customer(name: "", phone: "", email: "", rating: 0);
            Navigator.pushNamed(context, '/customer');
          },
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }
}
