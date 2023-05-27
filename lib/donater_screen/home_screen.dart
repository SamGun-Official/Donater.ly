import 'package:flutter/material.dart';

class DonaterHomeScreen extends StatefulWidget {
  static const routeName = '/donater_home_route';
  const DonaterHomeScreen({super.key});

  @override
  State<DonaterHomeScreen> createState() => _DonaterHomeScreenState();
}

class _DonaterHomeScreenState extends State<DonaterHomeScreen> {
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
                )
              ],
            ),
          ),
            )
          ],
        ),    
    );
  }
}