import 'package:flutter/material.dart';

Widget nodata() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/no-wifi.png',
            fit: BoxFit.cover, height: 150, width: 150),
        const SizedBox(
          height: 10,
        ),
        const Text('No Internet Connected',
            style: TextStyle(
                fontFamily: 'helve',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
      ],
    ),
  );
}
