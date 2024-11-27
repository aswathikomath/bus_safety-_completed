
import 'package:bus_safety/presentation/login.dart';
import 'package:bus_safety/presentation/send%20complaint.dart';
import 'package:bus_safety/presentation/sendfeedback.dart';
import 'package:bus_safety/presentation/tiket.dart';
import 'package:bus_safety/presentation/userprofile.dart';
import 'package:bus_safety/presentation/userticketview.dart';
import 'package:bus_safety/services/bookingstatusapi.dart';
import 'package:bus_safety/services/userprofileviewapi.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?", style: TextStyle(color: Colors.blueGrey)),
          content: Text("Do you really want to logout?", style: TextStyle(color: Colors.blueGrey)),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("OK", style: TextStyle(color: Colors.teal)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Proceed with logout
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Here you can clear any user data or authentication tokens if necessary
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()), // Redirect to login page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _Drawer(),
      appBar: AppBar(
        title: Text(
          "Bus Safety",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 34, 63, 93), // Deep blue color for AppBar
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 30, color: Colors.white),
            onPressed: () {
              _showLogoutDialog();
            }, // Logout action when logout icon is pressed
          ),
        ],
        toolbarHeight: 80,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 50),
          _buildActionCard(
            icon: Icons.directions_bus,
            label: "Book Your Ticket",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ticket()),
              );
            },
          ),
          SizedBox(height: 20),
          _buildActionCard(
            icon: Icons.feedback,
            label: "Send Complaint",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendComplaint()),
              );
            },
          ),
          SizedBox(height: 20),
          _buildActionCard(
            icon: Icons.history,
            label: "Booking Status",
            onTap: () async {
              // Fetch the booking statuses before navigating
              List<Map<String, dynamic>> statuses = await bookingstatuses();
              // Navigate to the Booking Status page with the fetched data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingStatusPage(bookingStatuses: statuses),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          _buildActionCard(
            icon: Icons.rate_review,
            label: "Send Feedback",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sendfeedback()),
              );
            },
          ),
          
        ],
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color.fromARGB(255, 245, 245, 245), // Light background color for the card
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon, size: 40, color: Colors.teal), // Teal icon color
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey), // Text color matching the theme
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 34, 63, 93), Color.fromARGB(255, 62, 89, 110)], // Gradient for the header
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Hi, Welcome 👋',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.teal),
            title: Text('Home', style: TextStyle(color: Colors.blueGrey)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text('Profile', style: TextStyle(color: Colors.blueGrey)),
            onTap: () async {
              Map<String, dynamic> profileData = await userprofileview();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => userprofilepage(profileData: profileData),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
