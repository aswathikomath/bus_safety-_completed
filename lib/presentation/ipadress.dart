import 'package:flutter/material.dart';

class ipadresses extends StatefulWidget {
  const ipadresses({super.key});

  @override
  State<ipadresses> createState() => _ipadressesState();
}

class _ipadressesState extends State<ipadresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(width: double.infinity,decoration: BoxDecoration(
          color: Colors.blue
        ),
        
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home),
                            labelText: 'ip address',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(onPressed: (){}, child:Text("submit")
             ) ],
            
            ),
          ),
        ),
      ),
    );
  }
}