import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';
import 'activity_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFE8F5E9), // Very light green tint for background as per image
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar Simulation
            _buildStatusBar(),

            // App Bar Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50), // Dark blue-gray text
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Profile Avatar & Info
                      _buildProfileHeader(),
                      const SizedBox(height: 24),

                      // Points Card
                      _buildPointsCard(),
                      const SizedBox(height: 24),

                      // Account Settings
                      _buildSectionHeader('Account Settings'),
                      _buildSettingsItem(
                          context, 'Edit Profile', Icons.person_rounded),
                      const SizedBox(height: 12),
                      _buildSettingsItem(
                          context, 'Notifications', Icons.notifications),
                      const SizedBox(height: 24),

                      // Activity History
                      _buildSectionHeader(
                          'Activity History'), // Or custom implementation for this one with subtitle
                      _buildActivityHistoryItem(context),
                      const SizedBox(height: 24),

                      // Preferences
                      _buildSectionHeader('Preferences'),
                      _buildSettingsItem(
                          context, 'Region Settings', Icons.location_on),
                      const SizedBox(height: 12),
                      _buildSettingsItem(
                          context,
                          'Appearance',
                          Icons
                              .dark_mode), // Using dark_mode as palette icon approximation
                      const SizedBox(height: 32),

                      // Logout Button
                      _buildLogoutButton(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildStatusBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:00',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, size: 16),
              SizedBox(width: 4),
              Icon(Icons.wifi, size: 16),
              SizedBox(width: 4),
              Icon(Icons.battery_full, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 50),
        ),
        const SizedBox(height: 12),
        const Text(
          'G.G.K.Ranudaya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'ggkranudaya@gmail.com',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Points',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                'View all',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF66BB6A), // Lighter green for card
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total points',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                    Text(
                      '1000',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF388E3C), // Darker green button
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    elevation: 0,
                  ),
                  child: const Text('Redeem',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0), // Light gray background for icon
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.grey[700], size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          if (title == 'Edit Profile') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()),
            );
          } else if (title == 'Notifications') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildActivityHistoryItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8), // slightly more padding
        title: const Text(
          'Activity History',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'View reported issues & pickups',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context, // This 'context' might not be available here, checking caller
            MaterialPageRoute(
                builder: (context) => const ActivityHistoryScreen()),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout,
            color: Colors.red), // Use standard logout icon
        label: const Text(
          'Log Out',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
          color: isActive ? const Color(0xFF4CAF50) : Colors.grey,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF4CAF50) : Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
