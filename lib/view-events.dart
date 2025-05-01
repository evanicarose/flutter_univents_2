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
  final DocumentReference orgRef;

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
  });

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
        future: fetchOrganizationFromReference(orgRef),
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
      // Stack containing the event banner image and the Interested section
      Stack(
        clipBehavior: Clip.none,
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
          // Positioned row with profile images and "Interested" text
          Positioned(
            top: 220,
            left: 45,
            right: 45,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 80, 
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage('assets/images/charlotte.jpeg'),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage('assets/images/mulan.jpeg'),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage('assets/images/anna.jpeg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20),
                  Text(
                    '+20 Interested',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2F3791),
                    ),
                  ),
                  SizedBox(width: 20),
                 
                  Container(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        // Invite logic
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF2F3791),
                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Invite'),
                    ),
                  ),
                ],
              ),
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
                          title,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 24),
                        // Organization Info
                        
                        SizedBox(height: 24),
                        // Event Date and Time
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
                                Text(dateTimeStart, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('$dayAndTime - $dateTimeEnd', style: TextStyle(color: Color.fromARGB(255, 133, 133, 133))),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 24),
                        // Event Location
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
                                    location, // Location text
                                    style: TextStyle(color: Color.fromARGB(255, 133, 133, 133)),
                                    overflow: TextOverflow.ellipsis,  // Cuts off text and adds "..."
                                    maxLines: 1,  // Limit the text to a single line
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
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(orgLogo),  // Replace orgLogo with the URL of the logo
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
                              onPressed: () {
                                
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 46, 96, 161), backgroundColor:Color.fromARGB(255, 160, 212, 255), 
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),  // Padding around the button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),  // Rounded corners
                                ),
                              ),
                              child: Text("Follow", style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        ),

                        SizedBox(height: 24),
                        // Event Description
                        Text('About Event', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8),
                        Text(description, style: TextStyle(fontSize: 16)),
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
    );
  }
}
