import 'package:flutter/material.dart';

class SidebarShowNotifications extends StatefulWidget {
  const SidebarShowNotifications({super.key});

  @override
  State<SidebarShowNotifications> createState() =>
      _SidebarShowNotificationsState();
}

class _SidebarShowNotificationsState extends State<SidebarShowNotifications> {
  bool showNotifications = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.08,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'Show Notifications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              value: showNotifications,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    showNotifications = value;
                  });
                } else {
                  setState(() {
                    showNotifications = value;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
