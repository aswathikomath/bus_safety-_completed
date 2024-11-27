
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/userpaymentapi.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> busList; // Add this line

  const PaymentScreen({Key? key, required this.busList}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMode = 'UPI';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();

  // Method to show the loading dialog
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Transaction Processing..."),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _amountController.text = widget.busList['fare']; 
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        backgroundColor: Color.fromARGB(255, 34, 63, 93),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 36, 52, 105),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 16, 36, 70)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Choose your Payment Mode',
                style: TextStyle(color: const Color.fromARGB(255, 16, 36, 70)),
              ),
              ListTile(
                title: Text(
                  'UPI',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Radio<String>(
                  value: 'UPI',
                  groupValue: _selectedPaymentMode,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMode = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMode == 'UPI')
                TextField(
                  controller: _upiController,
                  decoration: InputDecoration(
                    labelText: 'Enter UPI ID',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ListTile(
                title: Text(
                  'Debit Card',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Radio<String>(
                  value: 'Debit',
                  groupValue: _selectedPaymentMode,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMode = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Show loading dialog
                  _showLoadingDialog();
                  String busId = widget.busList['bus_loginid'].toString();

                  // Gather all data into a map
                  Map<String, String> paymentData = {
                    'amount': _amountController.text,
                    'payment_mode': _selectedPaymentMode,
                    'id': lid.toString(),
                    'bus_id': busId, // Ensure 'lid' is defined somewhere
                    if (_selectedPaymentMode == 'UPI') 'upi_id': _upiController.text,
                  };

                  print('Payment Data: $paymentData');

                  // Simulate a network call
                  try {
                    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
                    await payment(paymentData); // Call your payment function
                  } finally {
                    // Dismiss the loading dialog
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                 backgroundColor: Color.fromARGB(255, 34, 63, 93),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  minimumSize: Size(200.0, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  ),
                ),
                child: Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
