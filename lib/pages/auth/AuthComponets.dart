
import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

Widget title(context) {
  return Center(
    child: Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: colorScheme(context).surface,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Image.asset(
        'assets/img/ic_launcher.png',
      ),
    ),
  );
}


Widget restoreIcon() {
  return Align(
      alignment: Alignment.center,
      child: ImageIcon(
        const AssetImage('assets/img/renewable.png'),
        color: Colors.green.shade900,
        size: 100,
      ));
}


Widget restoreFailIcon() {
  return Align(
      alignment: Alignment.center,
      child: ImageIcon(
        const AssetImage('assets/img/pend.png'),
        color: Colors.red.shade600,
        size: 100,
      ));
}


Widget divider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
          ),
        ),
        Text(
          'or',
          style: TextStyle(color: Colors.grey[800]),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 1, color: Colors.grey[300]),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
