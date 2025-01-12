import 'package:cat_cat/percobaan/chat_screen.dart';
import 'package:cat_cat/percobaan/models/chat_user.dart';
import 'package:cat_cat/percobaan/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.user});

  final ChatUser user;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'gopay'; // Default selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50], // Light background
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        elevation: 0,
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatUserCard(user: widget.user),
            // Doctor Info Card
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       children: [
            //         // Doctor Avatar
            //         CircleAvatar(
            //           radius: 30,
            //           backgroundImage: AssetImage(
            //               'assets/image/doctor.png'), // Replace with your image asset
            //         ),
            //         const SizedBox(width: 16),
            //         // Doctor Details
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Dokter James',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold, fontSize: 18),
            //               ),
            //               Row(
            //                 children: List.generate(4, (index) {
            //                   return const Icon(
            //                     Icons.star,
            //                     color: Colors.amber,
            //                     size: 16,
            //                   );
            //                 })
            //                   ..add(const Icon(
            //                     Icons.star_border,
            //                     size: 16,
            //                     color: Colors.amber,
            //                   )),
            //               ),
            //               const SizedBox(height: 8),
            //               const Text(
            //                 'HARGA 1 SESI\nuntuk 45 menit chat',
            //                 style:
            //                     TextStyle(fontSize: 14, color: Colors.black54),
            //               ),
            //             ],
            //           ),
            //         ),
            //         // Price
            //         const Text(
            //           'Rp. 40.000',
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 16),

            // Total Price
            const Text(
              'TOTAL HARGA',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const Text(
              'Rp. 40.000',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(height: 32),

            // Voucher Section
            GestureDetector(
              onTap: () {
                // Handle voucher click
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Pakai Vouchermu',
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Methods
            const Text(
              'PILIH METODE PEMBAYARAN',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: RadioListTile(
                value: 'gopay',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
                title: Row(
                  children: [
                    Image.asset(
                      'assets/image/gopay2.png', // Replace with your payment icon
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text('Gopay'),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: RadioListTile(
                value: 'OVO',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
                title: Row(
                  children: [
                    Image.asset(
                      'assets/image/OVO.jpg', // Replace with your payment icon
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text('OVO'),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: RadioListTile(
                value: 'Mandiri Virtual Account',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
                title: Row(
                  children: [
                    Image.asset(
                      'assets/image/mandiri.png', // Replace with your payment icon
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text('Mandiri Virtual Account'),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: RadioListTile(
                value: 'BCA Virtual Account',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value.toString();
                  });
                },
                title: Row(
                  children: [
                    Image.asset(
                      'assets/image/bca.jpg', // Replace with your payment icon
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text('BCA Virtual Account'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bottom Checkout Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total Payment
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Total Pembayaranmu',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp. 40.000',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Checkout Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatScreen(user: widget.user)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'Bayar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
