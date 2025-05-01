import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_univents_2/customWidgets/dashboard_cards.dart';
import 'package:flutter_univents_2/dashboard_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_univents_2/index.dart';
import 'package:flutter_univents_2/all_events_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0; // Track the selected index for the BottomNavigationBar

  Future<List<DashboardCard>> fetchDashboardCards() async {
    final snapshot = await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) => DashboardCard.fromMap(doc.data())).toList();
  }

  Future<void> _signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const IndexScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Main"),
            ),
            ListTileTheme(
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              child: ExpansionTile(
                leading: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/dashboard.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text('Dashboard'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                childrenPadding: const EdgeInsets.only(left: 32),
                children: [
                  drawerListTile('Events', '', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllEventsPage()),
                    );
                  }),
                  drawerListTile('Map', '', () {
                    Navigator.pop(context);
                  }),
                  drawerListTile('Profile', '', () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
            drawerListTile('Your Events', 'assets/images/calendar.png', () {
              Navigator.pop(context);
            }),
            drawerListTile('Notification', 'assets/images/notification-bell.png', () {
              Navigator.pop(context);
            }),
            drawerListTile('Sign Out', 'assets/images/log-out.png', () => _signOut(context)),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Messages"),
                  Icon(Icons.add),
                ],
              ),
            ),
            messageTile("Rapunzel (Wifey)", "assets/images/rapunzel.jpeg", true,
                subtitle: "YOU HAVE A NEW MESSAGE", messageCount: "2"),
            messageTile("Maximus (Horsey)", "assets/images/maximus.jpeg", false),
            messageTile("Mother Gothel (Ex-Mom)", "assets/images/gothel.jpeg", true),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 62, 163),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            Text(
              'Jacinto, Davao City',
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(186, 34, 76, 165),
                  radius: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/bell.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 9,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.purple, width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: const Color.fromARGB(255, 15, 62, 163),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                searchBarWithFilter(),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 15, 62, 163),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryButton('Sports', "assets/images/volleyball.png",
                        const Color.fromARGB(255, 230, 109, 100)),
                    categoryButton('Music', "assets/images/music.png",
                        const Color.fromARGB(255, 230, 168, 75)),
                    categoryButton('Esports', "assets/images/multiplayer.png",
                        const Color.fromARGB(255, 84, 202, 165)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                upcomingEventsHeader(context),
                FutureBuilder<List<DashboardCard>>(
                  future: fetchDashboardCards(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No Dashboard Cards Found');
                    } else {
                      final cards = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: cards),
                      );
                    }
                  },
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: inviteCard(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 15, 62, 163),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllEventsPage()),
            );
          } if (index == 2){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllEventsPage()),
            );
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Material(
              shape: const CircleBorder(),
              child: Transform.translate(
                offset: Offset(0, -30),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 15, 62, 163),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 15, 62, 163),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Map',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
