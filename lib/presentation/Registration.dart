
import 'package:bus_safety/services/registrationapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _guardianController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedMartialStatus = 'Single';
  String _selectedIdType = 'Passport';
  DateTime _selectedDate = DateTime.now();
  String _address = '';
  Map<String, dynamic> registrationData = {};

  // ValueNotifier for gender selection
  ValueNotifier<String> _selectedGenderNotifier = ValueNotifier<String>('Male');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 255, 219),
        title: Text('Register Now'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(''), // Replace with your actual asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    title: const Text('Gender'),
                    subtitle: ValueListenableBuilder<String>(
                      valueListenable: _selectedGenderNotifier,
                      builder: (context, value, child) {
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Male'),
                                value: 'Male',
                                groupValue: value,
                                onChanged: (newValue) {
                                  _selectedGenderNotifier.value = newValue!;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Female'),
                                value: 'Female',
                                groupValue: value,
                                onChanged: (newValue) {
                                  _selectedGenderNotifier.value = newValue!;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Other'),
                                value: 'Other',
                                groupValue: value,
                                onChanged: (newValue) {
                                  _selectedGenderNotifier.value = newValue!;
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedMartialStatus,
                    decoration: InputDecoration(labelText: 'Martial Status'),
                    items: <String>['Single', 'Married', 'Divorced', 'Widowed']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMartialStatus = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _mobileNumberController,
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _guardianController,
                    decoration: InputDecoration(labelText: 'Guardian'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter guardian\'s name';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedIdType,
                    decoration: InputDecoration(labelText: 'Type of Identification Card'),
                    items: <String>['Passport', 'Driver\'s License', 'National ID']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedIdType = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address'),
                    onChanged: (value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        registrationData['name'] = _nameController.text;
                        registrationData['dob'] = _dobController.text;
                        registrationData['gender'] = _selectedGenderNotifier.value;
                        registrationData['mstatus'] = _selectedMartialStatus;
                        registrationData['phone'] = _mobileNumberController.text;
                        registrationData['username'] = _usernameController.text;
                        registrationData['password'] = _passwordController.text;
                        registrationData['gurd'] = _guardianController.text;
                        registrationData['type'] = _selectedIdType;
                        await regapi(registrationData);
                      }
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
