// ignore: file_names
import 'package:flutter/material.dart';

class ViewEvents extends StatelessWidget {
  final String title;
  final String banner;
  final String dateTimeStart;
  final String location;

  const ViewEvents(
      {super.key,
      required this.title,
      required this.banner,
      required this.dateTimeStart,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Image.network(
                  banner,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  child: AppBar(
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
              ))
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [Icon(Icons.calendar_month), Text(dateTimeStart)],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
