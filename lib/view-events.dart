import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewEvents extends StatefulWidget {
  final String title;
  final String banner;
  final String dateTimeStart;
  final String dateTimeEnd;
  final String location;
  final String dayAndTime;
  final String description;
  final DocumentReference orgRef;
  final String eventId;

  const ViewEvents({
    super.key,
    required this.title,
    required this.banner,
    required this.dateTimeStart,
    required this.dateTimeEnd,
    required this.location,
    required this.dayAndTime,
    required this.description,
    required this.orgRef,
    required this.eventId,
  });

  @override
  _ViewEventsState createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  bool isJoined = false;
  Timestamp? joinTimestamp;

  @override
  void initState() {
    super.initState();
    checkIfStudentJoined();
  }

  Future<void> checkIfStudentJoined() async {
    final studentId = FirebaseAuth.instance.currentUser?.uid;
    if (studentId == null) return;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('attendees')
        .where('accountid', isEqualTo: FirebaseFirestore.instance.collection('accounts').doc(studentId))
        .where('eventid', isEqualTo: FirebaseFirestore.instance.collection('events').doc(widget.eventId))
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        isJoined = true;
        joinTimestamp = querySnapshot.docs.first['datetimestamp'];
      });
    }
  }

  Future<void> toggleJoinStatus() async {
    final studentId = FirebaseAuth.instance.currentUser?.uid;
    if (studentId == null) return;

    final eventRef = FirebaseFirestore.instance.collection('events').doc(widget.eventId);
    final studentRef = FirebaseFirestore.instance.collection('attendees');

    if (isJoined) {
      // If "Joined" is clicked, remove the student from the event
      final querySnapshot = await studentRef
          .where('eventid', isEqualTo: eventRef)
          .where('accountid', isEqualTo: FirebaseFirestore.instance.collection('accounts').doc(studentId))
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      setState(() {
        isJoined = false;
        joinTimestamp = null;
      });
    } else {
      // If "Join" is clicked, add the student to the event
      await studentRef.add({
        'eventid': eventRef,
        'accountid': FirebaseFirestore.instance.collection('accounts').doc(studentId),
        'status': 'pending',
        'datetimestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        isJoined = true;
        joinTimestamp = Timestamp.now();
      });
    }
  }

  Future<Map<String, dynamic>?> fetchOrganizationFromReference(DocumentReference orgRef) async {
    final docSnapshot = await orgRef.get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchOrganizationFromReference(widget.orgRef),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Organization not found.'));
          } else {
            final organization = snapshot.data!;
            final orgName = organization['name'] ?? 'No name';
            final orgLogo = organization['logo'] ?? '';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.network(
                        widget.banner,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.white),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Title of the page
                            Text(
                              'Event Details',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            // Positioned Bookmark Icon
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Colors.white.withOpacity(.30), // White background with opacity
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.bookmark, // The red icon
                                color: Colors.white, // Red color for the icon
                                size: 20, // Icon size, adjust as needed
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        Text(
                          widget.title,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 160, 212, 255),
                              ),
                              child: Icon(Icons.calendar_month_rounded, color: Color.fromARGB(255, 0, 59, 107)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.dateTimeStart, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('${widget.dayAndTime} - ${widget.dateTimeEnd}', style: TextStyle(color: Color.fromARGB(255, 133, 133, 133))),
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
                                color: Color.fromARGB(255, 160, 212, 255),
                              ),
                              child: Icon(Icons.location_on_rounded, color: Color.fromARGB(255, 0, 59, 107)),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ateneo de Davao University', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(
                                    widget.location,
                                    style: TextStyle(color: Color.fromARGB(255, 133, 133, 133)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(orgLogo),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orgName,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Organizer",
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 46, 96, 161),
                                backgroundColor: Color.fromARGB(255, 160, 212, 255),
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Follow", style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Text('About Event', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8),
                        Text(widget.description, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F3791),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: toggleJoinStatus,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Text(
                        isJoined ? "JOINED" : "JOIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4D5DFB),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
