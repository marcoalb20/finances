import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HugeIcon(
              icon: HugeIcons.strokeRoundedMenuCircle,
              size: 25,
              color: Colors.black,
            ),
            Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedMoon02,
                  size: 25,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    size: 25,
                    color: Colors.white,
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
