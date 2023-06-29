import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multiplatform_donation_app/models/donation.dart';

class DonaterDonateScreen extends StatefulWidget {
  static const routeName = '/donater_donate';
  const DonaterDonateScreen({super.key});

  @override
  State<DonaterDonateScreen> createState() => _DonaterDonateScreenState();
}

class _DonaterDonateScreenState extends State<DonaterDonateScreen> {
  var selectedIcon = Icons.credit_card;
  int selectedPaymentMethod = 0; // 0 = Credit Card, 1 = Cash
  bool isEmptyCVV = true;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  double subtotal = 0.0;
  double tax = 0.0;
  double total = 0.0;

  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  void updateAmount(String value) {
    if (value.isNotEmpty) {
      double amount = double.parse(value);
      setState(() {
        subtotal = amount;
        tax = amount * 0.1;
        total = subtotal + tax;
      });
    } else {
      setState(() {
        subtotal = 0.0;
        tax = 0.0;
        total = 0.0;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Donation donation = args['donation'] as Donation;
    final Function updateDonation = args['updateDonation'] as Function;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        final updatedDonationSnapshot = await FirebaseFirestore
                            .instance
                            .collection('Donations')
                            .where('id', isEqualTo: donation.id)
                            .get();

                        if (updatedDonationSnapshot.docs.isNotEmpty) {
                          final data =
                              updatedDonationSnapshot.docs.first.data();
                          final updatedDonation = Donation(
                              id: data['id'],
                              imagePath: data['imagePath'],
                              title: data['title'],
                              subtitle: data['subtitle'],
                              description: data['description'],
                              fundraiser: data['fundraiser'],
                              isFundraiserVerified:
                                  data['isFundraiserVerified'],
                              daysLeft: data['daysLeft'],
                              donaterCount: data['donaterCount'],
                              progress:
                                  double.parse(data['progress'].toString()),
                              collectedAmount: data['collectedAmount'],
                              donationNeeded: data['donationNeeded'],
                              category: data['category']);
                          updateDonation(updatedDonation);
                          if (!mounted) return;
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                    const Text(
                      'Donate',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Opacity(
                        opacity: 0.0,
                        child: Icon(
                          Icons.bookmark_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    'Donation Recipient',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.5,
                      ), // Mengatur warna dengan transparansi
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: const DecorationImage(
                                image: AssetImage('images/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                donation.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        donation.fundraiser,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Amount (Min. Rp100,00)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: updateAmount,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            hintText: '50000',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: selectedIcon,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedIcon = newValue!;
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: Icons.credit_card,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.credit_card),
                                              SizedBox(width: 8),
                                              Text('Credit Card'),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedPaymentMethod = 0;
                                            });
                                          },
                                        ),
                                        DropdownMenuItem(
                                          value: Icons.monetization_on,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.monetization_on),
                                              SizedBox(width: 8),
                                              Text('Cash'),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedPaymentMethod = 1;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: selectedPaymentMethod == 0 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expired Date',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  controller: _dateController,
                                  readOnly: true,
                                  onTap: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        _dateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    hintText: 'Select Date',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CVV',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    hintText: 'CVV',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        isEmptyCVV = true;
                                      });
                                    } else {
                                      setState(() {
                                        isEmptyCVV = false;
                                      });
                                    }
                                  },
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Rp${subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tax',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Rp${tax.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                        onPressed: (_amountController.text.isEmpty ||
                                (selectedPaymentMethod == 0 &&
                                    (_dateController.text.isEmpty ||
                                        isEmptyCVV)))
                            ? null
                            : () {
                                final amount = total;
                                final expiredDate = _dateController.text;
                                final cvv = _cvvController.text.toString();
                                final paymentMethod =
                                    ((selectedIcon == Icons.credit_card)
                                        ? "credit card"
                                        : "cash");

                                try {
                                  if (amount < 100) {
                                    throw Exception("Minimum amount is Rp100!");
                                  }
                                  if (selectedPaymentMethod == 0) {
                                    DateTime expiredDateValue =
                                        DateTime.parse(expiredDate);
                                    DateTime todayDateValue = DateTime.now();
                                    if (!DateUtils.isSameDay(
                                            expiredDateValue, todayDateValue) &&
                                        expiredDateValue
                                                .compareTo(todayDateValue) <
                                            0) {
                                      throw Exception(
                                          "Expired date is not valid!");
                                    }
                                  }

                                  DateTime donationDate = DateTime.now();
                                  DateFormat dateFormatter =
                                      DateFormat("yyyy-MM-dd");

                                  firestore.collection('UserDonates').add({
                                    'CVV':
                                        selectedPaymentMethod == 1 ? null : cvv,
                                    'donationID': donation.id,
                                    'expiredDate': selectedPaymentMethod == 1
                                        ? null
                                        : dateFormatter.format(
                                            DateTime.parse(expiredDate)),
                                    'paymentMethod': paymentMethod,
                                    'total': double.parse(amount.toString()),
                                    'userUID': currentUser.uid,
                                    'donationDate':
                                        dateFormatter.format(donationDate),
                                    'donationTimestamp': donationDate
                                  }).then((value) {
                                    firestore
                                        .collection('Donations')
                                        .where('id', isEqualTo: donation.id)
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      if (querySnapshot.docs.isNotEmpty) {
                                        for (QueryDocumentSnapshot donationDocument
                                            in querySnapshot.docs) {
                                          final donationId =
                                              donationDocument.id;
                                          final currentCollectedAmount =
                                              donationDocument.get(
                                                          'collectedAmount')
                                                      as int? ??
                                                  0;
                                          final donaterCount = donationDocument
                                                      .get('donaterCount')
                                                  as int? ??
                                              0;

                                          final updatedCollectedAmount =
                                              currentCollectedAmount +
                                                  amount.toInt();

                                          final double progress =
                                              (updatedCollectedAmount /
                                                  (donationDocument.get(
                                                              'donationNeeded')
                                                          as int? ??
                                                      1));
                                          final double roundedProgress =
                                              double.parse(
                                                  progress.toStringAsFixed(1));

                                          firestore
                                              .collection('Donations')
                                              .doc(donationId)
                                              .update({
                                                'collectedAmount':
                                                    updatedCollectedAmount,
                                                'donaterCount':
                                                    donaterCount + 1,
                                                'progress': roundedProgress
                                              })
                                              .then((_) {})
                                              .catchError((error) {
                                                debugPrint(
                                                    'Error updating collected amount: $error');
                                              });
                                        }
                                      } else {
                                        debugPrint('Donation not found');
                                      }
                                    }).catchError((error) {
                                      debugPrint(
                                          'Error retrieving donation: $error');
                                    });

                                    const snackbar = SnackBar(
                                        content: Text("Donate successful!"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);

                                    Navigator.of(context).pop();
                                  });
                                } catch (e) {
                                  String errorMessage = e.toString();
                                  int index = errorMessage.indexOf(':');
                                  String formattedErrorMessage = index != -1
                                      ? errorMessage.substring(index + 2).trim()
                                      : errorMessage;

                                  final snackbar = SnackBar(
                                      content: Text(formattedErrorMessage));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Menambahkan border radius
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Donate Now'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
