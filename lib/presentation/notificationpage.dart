import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  NotificationsPage({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: notifications.isEmpty
          ? Center(child: Text('No notifications available'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  child: ListTile(
  contentPadding: EdgeInsets.all(16),
  title: Text(
    notification['loginid']?.toString() ?? 'No Bus ID',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Display notification message
      Text(notification['notification'] ?? 'No Message'),

      // Display speed
      Text('Speed: ${notification['speed'] ?? 'No Speed'}'),

      // Display bus registration number
      Text('Bus Registration: ${notification['reg_no'] ?? 'No Registration Number'}'),

      // Display date
      Text('Date: ${notification['date'] ?? 'No Date'}'),

      // Display time
      Text('Time: ${notification['time'] ?? 'No Time'}'),
    ],
  ),
),


                );
              },
            ),
    );
  }
}
