import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Function()? onTap;

  const AppButton({super.key, required this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFC6F54C),
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 56),
        shape: StadiumBorder(),
        elevation: 10,
      ),
      onPressed: onTap ?? () {},
      label: Text(title),
    );
  }
}
