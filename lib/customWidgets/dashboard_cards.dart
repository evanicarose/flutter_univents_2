import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_univents_2/view-events.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String banner;
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final String location;
  final String description;
  final DocumentReference orgRef; // Add orgRef to constructor
  final String eventId; // Add eventId to constructor
  final bool isVisible;

  const DashboardCard({
    super.key,
    required this.title,
    required this.banner,
    required this.dateTimeStart,
    required this.location,
    required this.dateTimeEnd,
    required this.description,
    required this.orgRef,
    required this.isVisible,
    required this.eventId, // Accept eventId as a parameter
  });

  factory DashboardCard.fromMap(Map<String, dynamic> map) {
    final Timestamp timestampStart = map['datetimestart'];
    final Timestamp timestampEnd = map['datetimeend'];
    final DateTime dateTimeStart = timestampStart.toDate();
    final DateTime dateTimeEnd = timestampEnd.toDate();
    final String location = map['location'] ?? "";
    final String title = map['title'];
    final bool isVisible = map['isVisible'] ?? false; // Parse isVisible field

    // Extract orgRef and eventId from the map
    final DocumentReference orgRef =
        map['orguid']; // Assuming 'orguid' is the reference to the organization
    final String eventId = map['uid']; // Assuming 'uid' is the eventId

    return DashboardCard(
      title: title,
      banner: map['banner'] ?? '',
      dateTimeStart: dateTimeStart,
      dateTimeEnd: dateTimeEnd,
      location: location,
      description: map['description'] ?? '',
      orgRef: orgRef, // Pass orgRef here
      eventId: eventId, // Pass eventId here
      isVisible: isVisible,
    );
  }

  @override
  Widget build(BuildContext context) {
    String month = DateFormat('MMM').format(dateTimeStart);
    String day = DateFormat('dd').format(dateTimeStart);
    String fullDateTimeStart =
        DateFormat('dd MMMM, yyyy').format(dateTimeStart);
    String dayAndTime = DateFormat("EEEE, h:mm a").format(dateTimeStart);
    String endTime = DateFormat('h:mm a').format(dateTimeEnd);

    int maxCharsTitle = 18;
    int maxCharsLocation = 20;

    String partialLocation = location.length > maxCharsLocation
        ? '${location.substring(0, maxCharsLocation)}...'
        : location;

    String partialTitle = title.length > maxCharsTitle
        ? '${title.substring(0, maxCharsTitle)}...'
        : title;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        height: 260,
        width: 250,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewEvents(
                  title: title,
                  banner: banner,
                  dateTimeStart: fullDateTimeStart,
                  dateTimeEnd: endTime,
                  location: location,
                  dayAndTime: dayAndTime,
                  description: description,
                  orgRef: orgRef,
                  eventId: eventId, // Pass eventId here
                ),
              ),
            );
          },
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                banner,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 140,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Opacity(
                              opacity: .85,
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 12),
                                  child: Column(
                                    children: [
                                      Text(
                                        day,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        month,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        partialTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            partialLocation,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20, // Adjust top position as needed
                  right: 20, // Adjust right position as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white
                          .withOpacity(0.85), // White background with opacity
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.bookmark, // The red icon you mentioned
                      color: const Color.fromARGB(
                          255, 238, 105, 96), // Red color for the icon
                      size: 20, // Icon size, adjust as needed
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
