import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.iconColor,
  });
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Toggle States
  bool pickupRemindersEnabled = true;
  bool truckTrackingEnabled = true;
  bool specialPickupsEnabled = false;
  bool systemUpdatesEnabled = true;

  // Notification History
  List<NotificationItem> notifications = [
    NotificationItem(
      title: "Garbage Collection Tomorrow",
      message: "Your waste will be collected at 8:00 AM",
      time: "2 hours ago",
      isRead: false,
      icon: Icons.local_shipping,
      iconColor: const Color(0xFF4CAF50),
    ),
    NotificationItem(
      title: "Truck Nearby",
      message: "Collection truck is 5 minutes away",
      time: "1 day ago",
      isRead: false,
      icon: Icons.location_on,
      iconColor: const Color(0xFF2196F3),
    ),
    NotificationItem(
      title: "Collection Completed",
      message: "Waste collected successfully",
      time: "2 days ago",
      isRead: true,
      icon: Icons.check_circle,
      iconColor: const Color(0xFF9E9E9E),
    ),
  ];

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear All Notifications?"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Clear All"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light gray background
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar & Header
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Notification Settings Section
                  _buildSectionHeader("Notification Settings"),
                  const SizedBox(height: 12),
                  _buildToggleCard(
                    key: const Key('pickupRemindersTile'),
                    title: "Pickup Reminders",
                    subtitle: "Get notified before garbage collection",
                    value: pickupRemindersEnabled,
                    onChanged: (val) =>
                        setState(() => pickupRemindersEnabled = val),
                  ),
                  const SizedBox(height: 8),
                  _buildToggleCard(
                    key: const Key('truckTrackingTile'),
                    title: "Truck Tracking",
                    subtitle: "Live updates when truck is nearby",
                    value: truckTrackingEnabled,
                    onChanged: (val) =>
                        setState(() => truckTrackingEnabled = val),
                  ),
                  const SizedBox(height: 8),
                  _buildToggleCard(
                    key: const Key('specialPickupsTile'),
                    title: "Special Pickups",
                    subtitle: "Updates on special pickup requests",
                    value: specialPickupsEnabled,
                    onChanged: (val) =>
                        setState(() => specialPickupsEnabled = val),
                  ),
                  const SizedBox(height: 8),
                  _buildToggleCard(
                    key: const Key('systemUpdatesTile'),
                    title: "System Updates",
                    subtitle: "App updates and announcements",
                    value: systemUpdatesEnabled,
                    onChanged: (val) =>
                        setState(() => systemUpdatesEnabled = val),
                  ),
                  const SizedBox(height: 24),

                  // Notification History Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionHeader("Recent Notifications"),
                      if (notifications.isNotEmpty)
                        TextButton(
                          onPressed: _clearAllNotifications,
                          child: const Text(
                            "Clear All",
                            style: TextStyle(
                              color: Color(0xFFF44336),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (notifications.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          "No notifications",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...notifications.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: _buildNotificationCard(item),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Status Bar Simulation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('9:00',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Row(
                children: const [
                  Icon(Icons.signal_cellular_alt, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.wifi, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.battery_full, size: 16),
                ],
              ),
            ],
          ),
        ),
        // AppBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Notifications',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Balance for back button
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildToggleCard({
    Key? key,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF4CAF50),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        key: key,
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Show details or navigate
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: item.iconColor,
                radius: 20,
                child: Icon(item.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF212121),
                          ),
                        ),
                        Text(
                          item.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              if (!item.isRead)
                Container(
                  margin: const EdgeInsets.only(left: 8, top: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'HOME', false),
            _buildNavItem(Icons.menu_book, 'GUIDE', false),
            _buildNavItem(Icons.map, 'MAP', false),
            _buildNavItem(Icons.person, 'PROFILE', true),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF757575),
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF757575),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
