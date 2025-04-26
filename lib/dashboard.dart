import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_univents_2/index.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
            DrawerHeader(
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
            ),

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
                  ListTile(
                    title: const Text('Events'),
                    
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      Navigator.pop(context);
                     
                    },
                  ),
                  ListTile(
                    title: const Text('Map'),
                    
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      Navigator.pop(context);
                     
                    },
                  ),
                  ListTile(
                    title: const Text('Profile'),
                    
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      Navigator.pop(context);
                      
                    },
                  ),
                ],
              ),
            ),

            ListTile(
              title: const Text('Your Events'),
              leading: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                       
                      image: DecorationImage(
                        image: AssetImage("assets/images/calendar.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Notification'),
              leading: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      
                      image: DecorationImage(
                        image: AssetImage("assets/images/notification-bell.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              leading: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      
                      image: DecorationImage(
                        image: AssetImage("assets/images/log-out.png"),
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              onTap: () => _signOut(context),
            ),
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
            Padding(
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/rapunzel.jpeg"),
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
                                color: Colors.green,
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
                          const Text(
                            "Rapunzel (Wifey)",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "YOU HAVE A NEW MESSAGE",
                            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 237, 132, 132),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "2",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/maximus.jpeg"),
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
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2), 
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Maximus (Horsey)",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/gothel.jpeg"),
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
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2), 
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Mother Gothel (Ex-Mom)",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
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
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
                  onPressed: () {

                  },
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

      centerTitle: true,
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                         
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Color.fromARGB(255, 214, 210, 210)),
                            SizedBox(width: 13),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
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
                        color: Color.fromARGB(255, 112, 114, 245),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 195, 193, 193),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, 
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),

          Stack(
  clipBehavior: Clip.none,
  children: [
    // Bottom container with rounded bottom corners
    Container(
      width: double.infinity,
      height: 30,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 15, 62, 163),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
    ),

    // Row of tabs/buttons, overlapping halfway
    Positioned(
      top: 10, 
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: 110,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 109, 100),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/volleyball.png",
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 8,),
                const Text("Sports", style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: 110,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 168, 75),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/music.png",
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 8,),
                const Text("Music", style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: 110,
            height: 45,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 84, 202, 165),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/multiplayer.png",
                  width: 20,
                  height: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 8,),
                const Text("Esports", style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
),



          const Expanded(
            child: Center(
              child: Text('Welcome to the Home Page!'),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 15, 62, 163),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Events',
            backgroundColor: Color.fromARGB(255, 148, 144, 144),
          ),
          BottomNavigationBarItem(
                icon: Material(
                  
                  shape: CircleBorder(),
                  child: Transform.translate(
                    offset: Offset(0, -30), 
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 15, 62, 163), 
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: const Color.fromARGB(255, 15, 62, 163), 
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
