import 'package:th_0809/app/data/api.dart';
import 'package:th_0809/app/data/sqlite.dart';
import 'package:th_0809/app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Cart List"),
        Expanded(
          flex: 11,
          child: FutureBuilder<List<Cart>>(
            future: _getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final itemProduct = snapshot.data![index];
                    return _buildProduct(itemProduct, context);
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
            flex: 1,
            child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  List<Cart> temp = await _databaseHelper.products();
                  await APIRepository()
                      .addBill(temp, pref.getString('token').toString());
                  _databaseHelper.clear();
                },
                child: Text("Payment")))
      ],
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              child: Text(
                pro.productID.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    NumberFormat('#,##0').format(pro.price),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                  // const SizedBox(height: 4.0),
                  // Text('Category: ${pro.catId}'),
                  const SizedBox(height: 4.0),
                  Text('Count: ' + pro.count.toString()),
                  Text('Description: ' + pro.des),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    DatabaseHelper().minus(pro);
                  });
                },
                icon: Icon(
                  Icons.minimize_outlined,
                  color: Colors.yellow.shade800,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    DatabaseHelper().deleteProduct(pro.productID);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    DatabaseHelper().add(pro);
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.yellow.shade800,
                ))
          ],
        ),
      ),
    );
  }
}
