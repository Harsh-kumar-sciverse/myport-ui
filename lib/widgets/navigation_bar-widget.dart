import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final String title;
  final Widget startWidget;
  final Widget endWidget;
  const NavigationBarWidget(
      {Key? key,
      required this.title,
      required this.endWidget,
      required this.startWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0xFF1CA2A8),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          startWidget,
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          endWidget
        ],
      ),
    );
  }
}
