// import 'package:flutter/material.dart';
//  // Import the qr_flutter package

// class QRCodeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background network image
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     'https://img.freepik.com/premium-photo/bus-road_81048-20396.jpg?w=740', // Replace with your image URL
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           // QR Code
//           Center(
//             child: QrImage(
//               data: 'https://example.com', // Data for the QR code
//               size: 200.0,
//               backgroundColor: Colors.transparent, // Make background of QR code transparent
//               foregroundColor: Colors.white, // Color of QR code
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
