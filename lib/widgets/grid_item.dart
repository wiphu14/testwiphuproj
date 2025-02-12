import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              'images/avatar.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: const Text(
              "Product Name",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: const Text(
              "Short Description",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: const Text(
              "\$100.00",
            ),
          ),
        ],
      ),
    );
  }
}
