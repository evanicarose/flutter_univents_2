// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewEvents extends StatelessWidget {
  final String title;
  final String banner;
  final String dateTimeStart;
  final String dateTimeEnd;
  final String location;
  final String dayAndTime;
  final String description;

  // final DocumentReference orguid;

  const ViewEvents({
    super.key,
    required this.title,
    required this.banner,
    required this.dateTimeStart,
    required this.location,
    required this.dayAndTime,
    required this.dateTimeEnd,
    required this.description,
    // required this.orguid,
  });

  Future<Map<String, dynamic>?> fetchOrganizationFromReference(
      DocumentReference orgRef) async {
    final docSnapshot = await orgRef.get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    int maxCharsLocation = 20;
    String partialLocation = location.length > maxCharsLocation
        ? '${location.substring(0, maxCharsLocation)}...'
        : location;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  banner,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'Event Details',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 160, 212, 255)),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: const Color.fromARGB(255, 0, 59, 107),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateTimeStart,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$dayAndTime - $dateTimeEnd',
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 133, 133, 133)),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 160, 212, 255)),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: const Color.fromARGB(255, 0, 59, 107),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ateneo de Davao University',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            partialLocation,
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 133, 133, 133)),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'About Event',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24), // Add some bottom spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
