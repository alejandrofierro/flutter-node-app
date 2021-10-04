import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/providers/customer_form_provider.dart';
import 'package:flutter_contacts/services/customer_service.dart';
import 'package:flutter_contacts/ui/input_decorations.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customerService = Provider.of<CustomerService>(context);

    return ChangeNotifierProvider(
      create: (_) => CustomerFormProvider(customerService.selectedCustomer),
      child: _CustomerScreenBody(customerService: customerService),
    );
  }
}

class _CustomerScreenBody extends StatelessWidget {
  const _CustomerScreenBody({
    Key? key,
    required this.customerService,
  }) : super(key: key);

  final CustomerService customerService;

  @override
  Widget build(BuildContext context) {
    final customerForm = Provider.of<CustomerFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Customer : " + customerService.selectedCustomer.name,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  customerService.deleteCustomer(customerForm.customer);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                    decoration: _BuildBoxDecoration(),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: _CustomerForm()),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("hola");
              customerService.saveOrCreateCustomer(customerForm.customer);
            },
            child: customerService.isSaving
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Icon(Icons.save_outlined)),
      ),
    );
  }

  BoxDecoration _BuildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)
          ]);
}

class _CustomerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customerForm = Provider.of<CustomerFormProvider>(context);
    final customer = customerForm.customer;
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: customerForm.formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: customer.name,
            onChanged: (value) => {customer.name = value},
            decoration: InputDecorations.loginInputDecoration(
                hintText: "Enter the customer name",
                labelText: "Customer Name"),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: customer.phone,
            keyboardType: TextInputType.phone,
            onChanged: (value) => {customer.phone = value},
            decoration: InputDecorations.loginInputDecoration(
                hintText: "Enter the customer phone",
                labelText: "Customer Phone"),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            initialValue: customer.email,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? "") ? null : "Invalid email";
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => {customer.email = value},
            decoration: InputDecorations.loginInputDecoration(
                hintText: "Enter the customer email",
                labelText: "Customer Email"),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text("Customer Probability: " +
                      customer.rating.round().toString()),
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                  )
                ],
              ),
              Divider(),
              Slider(
                  value: customer.rating,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: customer.rating.round().toString(),
                  onChangeStart: (value) {
                    customerForm.updateRating(value);
                  },
                  onChangeEnd: (value) {
                    customerForm.updateRating(value);
                  },
                  onChanged: (value) {
                    customerForm.updateRating(value);
                  }),
            ],
          ),
          // TextFormField(
          //   initialValue: customer.rating,
          //   onChanged: (value) => {customer.rating = value},
          //   maxLines: 1,
          //   keyboardType: TextInputType.number,
          //   decoration: InputDecorations.loginInputDecoration(
          //       hintText: "Enter the probability to become a customer",
          //       labelText: "Customer Probability "),
          // ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
