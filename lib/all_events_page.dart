import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_univents_2/view-events.dart';
import 'package:intl/intl.dart';

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({super.key});

  Future<List<Map<String, dynamic>>> fetchAllEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('events').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'title': data['title'] ?? '',
        'description': data['description'] ?? '',
        'location': data['location'] ?? '',
        'datetimestart': data['datetimestart'],
        'datetimeend': data['datetimeend'],
        'banner': data['banner'] ?? '',
        'status': data['status'] ?? '',
        'tags': data['tags'] ?? '',
        'type': data['type'] ?? '',
        'uid': data['uid'] ?? '',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events found.'));
          } else {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final dateTimeEnd = event['datetimeend'] as Timestamp?;
                final dateTimeEndToDate = dateTimeEnd?.toDate();
                final formattedDateEnd = dateTimeEndToDate != null
                    ? DateFormat('E, MMM d · h:mm a').format(dateTimeEndToDate)
                    : 'No Date';
                final timestampStart = event['datetimestart'] as Timestamp?;
                final dateTimeStart = timestampStart?.toDate();
                final formattedDate = dateTimeStart != null
                    ? DateFormat('E, MMM d · h:mm a').format(dateTimeStart)
                    : 'No Date';
                final formattedDateStart = dateTimeStart != null
                    ? DateFormat('dd MMMM, yyyy').format(dateTimeStart)
                    : 'No Date';
                final dayAndTime =
                    DateFormat("EEEE, h:mm a").format(dateTimeStart!);

                final endTime = DateFormat('h:mm a').format(dateTimeEndToDate!);

                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewEvents(
                                  title: event['title'],
                                  banner: event['banner'],
                                  dateTimeStart: formattedDateStart,
                                  dateTimeEnd: endTime,
                                  location: event['location'],
                                  dayAndTime: dayAndTime,
                                  description: event['description'])),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(6),
                          title: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: event['banner'] != null &&
                                            event['banner'] != ""
                                        ? NetworkImage(event['banner'])
                                        : const AssetImage(
                                                'assets/default_image.png')
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 59, 30, 171)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event['title'] ?? 'No Title',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 14, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            event['location'] ?? 'No Location',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
