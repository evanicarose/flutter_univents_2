import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_univents_2/all_events_page.dart';

Widget drawerHeader() {
  return DrawerHeader(
    decoration: const BoxDecoration(color: Colors.white),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 3),
            image: const DecorationImage(
              image: AssetImage("assets/images/flynn-rider.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FirebaseAuth.instance.currentUser?.displayName ?? 'Guest User',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                FirebaseAuth.instance.currentUser?.email ?? 'No email',
                style: const TextStyle(
                  color: Color.fromARGB(255, 139, 136, 136),
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget drawerListTile(String title, String? imagePath, VoidCallback onTap) {
  return ListTile(
    title: Text(title),
    leading: imagePath != null && imagePath.isNotEmpty
        ? Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          )
        : null,
    onTap: onTap,
  );
}

Widget messageTile(String name, String imagePath, bool isOnline,
    {String? subtitle, String? messageCount}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w200),
                  ),
              ],
            ),
          ],
        ),
        if (messageCount != null)
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 237, 132, 132),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              messageCount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

class SearchBarWithFilter extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const SearchBarWithFilter({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search,
                    color: Color.fromARGB(255, 214, 210, 210)),
                const SizedBox(width: 13),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: widget.searchController,
                    onChanged: widget
                        .onSearchChanged, // Call the callback on input change
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 82, 106, 160),
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 112, 114, 245),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 195, 193, 193),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.filter_list,
                  color: Color.fromARGB(255, 112, 114, 245),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Filters',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget categoryButton(String text, String imagePath, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    width: 110,
    height: 45,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        Image.asset(
          imagePath,
          width: 20,
          height: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    ),
  );
}

Widget inviteCard() {
  return Card(
    elevation: 0,
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Invite your friends',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

Widget upcomingEventsHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllEventsPage()),
            );
          },
          child: Row(
            children: [
              const Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 123, 125, 127),
                ),
              ),
              Icon(Icons.arrow_right)
            ],
          ),
        ),
      ],
    ),
  );
}
