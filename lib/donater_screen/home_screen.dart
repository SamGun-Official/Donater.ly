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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_white.jpg'), // Ganti dengan path/lokasi gambar Anda
              fit: BoxFit.cover,
            ),
        ),
          child: Center(
            child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color.fromRGBO(107,147,225,1), // Change the border color
                hintColor: Colors.blueGrey, // Change the hint text color
            ),
            child: ListView(
              children:[
                  Container( //container card
                    width: MediaQuery.of(context).size.width,
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
                                //image
                                radius: 40,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Welcome, Clarissa", //welcome, name
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
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Saldo: 50000',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
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
          ),
            )
          ],
        ),    
    );
  }
}