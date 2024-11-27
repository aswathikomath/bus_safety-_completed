
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/profileupdateapi.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  final Map<String, dynamic> profileData; // Assuming user data will be passed to this page.

  ProfileEditPage({required this.profileData});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _guardianController;
  
String? _selectedGender;
String? _selectedMartialStatus;
String? _selectedIdType;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profileData['name']?.toString());
    _dobController = TextEditingController(text: widget.profileData['dob']?.toString());
    _mobileNumberController = TextEditingController(text: widget.profileData['phone']?.toString());
    _guardianController = TextEditingController(text: widget.profileData['gurd']?.toString());
     
    _selectedGender = widget.profileData['gender']?.toString();
    _selectedMartialStatus = widget.profileData['mstatus']?.toString();
    _selectedIdType = widget.profileData['type']?.toString();
    print('Gender from profile data: ${widget.profileData['gender']}');

  }
    Map<String, dynamic> updatedData = {};
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
    print(_selectedMartialStatus);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 89, 255, 219),
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
  subtitle: Column(
    children: <Widget>[
      RadioListTile<String>(
        title: const Text('Male'),
        value: 'male',
        groupValue: _selectedGender,
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
      ),
      RadioListTile<String>(
        title: const Text('Female'),
        value: 'female',
        groupValue: _selectedGender,
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
      ),
      RadioListTile<String>(
        title: const Text('Other'),
        value: 'other',
        groupValue: _selectedGender,
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
      ),
    ],
  ),
),

              DropdownButtonFormField<String>(
                value: _selectedMartialStatus,
                decoration: InputDecoration(labelText: 'Martial Status'),
                 items: <String>['Single', 'married', 'Divorced', 'Widowed']
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
                items: <String>['passport', 'Driver\'s License', 'National ID']
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
             
              SizedBox(height: 20),
             ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      // Update user data logic here.
      Map<String, dynamic> updatedData = {
        'name': _nameController.text,
        'dob': _dobController.text,
        'gender': _selectedGender,
        'mstatus': _selectedMartialStatus,
        'phone': _mobileNumberController.text,
        'gurd': _guardianController.text,
        'type': _selectedIdType,
        'id':lid
      };

      // Print the updated data
      print('Updated Data: $updatedData');
       print('dfgvbhnhgggg');
       await userupdatedata(updatedData,context);

      // Call your update API here with updatedData
      // await updateUserProfile(updatedData);

      // Navigator.pop(context, updatedData); // Navigate back after update
    }
  },
  child: Text('Save Changes'),
),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _mobileNumberController.dispose();
    _guardianController.dispose();
   
    super.dispose();
  }
}
