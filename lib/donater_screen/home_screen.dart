import 'package:flutter/material.dart';

class DonaterHomeScreen extends StatefulWidget {
  static const routeName = '/donater_home_route';
  const DonaterHomeScreen({super.key});

  @override
  State<DonaterHomeScreen> createState() => _DonaterHomeScreenState();
}

class _DonaterHomeScreenState extends State<DonaterHomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
          child: Center(
            child: ListView(
              children:[
                  Container( //container card
                    width: double.infinity,
                    child: Card(
                    color: Color.fromRGBO(107,147,225,1), // Ubah warna card sesuai kebutuhan
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Ubah nilai border radius sesuai kebutuhan
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                              
                                radius: 40,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Welcome, Clarissa",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.89,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(8),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Color.fromRGBO(107,147,225,1)
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Rp 1.500.000 total donation',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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
                  ),
                ),
                Container(
                 width:MediaQuery.of(context).size.width*0.89,
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey, // Change the icon color
                          ),
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                 ),
                )
              ],
            ),
             ),
            )
          ],
        ),    

        bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(107,147,225,1),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),

    );
  }
}