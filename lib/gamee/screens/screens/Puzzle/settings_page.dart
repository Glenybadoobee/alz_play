import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFABE7FF),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBEE9FF), Color(0xFFFFE5B4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            _buildSettingTile(
              context,
              icon: Icons.volume_up,
              title: 'Sound',
              subtitle: 'Toggle game sounds',
              onTap: () {
                // Add your sound toggle logic here
              },
            ),
            const SizedBox(height: 15),
            _buildSettingTile(
              context,
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Enable or disable notifications',
              onTap: () {
                // Add your notification settings logic here
              },
            ),
            const SizedBox(height: 15),
            _buildSettingTile(
              context,
              icon: Icons.palette,
              title: 'Theme',
              subtitle: 'Change the app theme',
              onTap: () {
                // Add theme change logic here
              },
            ),
            const SizedBox(height: 15),
            _buildSettingTile(
              context,
              icon: Icons.info,
              title: 'About',
              subtitle: 'App version and info',
              onTap: () {
                // Show about dialog or info page
              },
            ),
            const SizedBox(height: 15),
            _buildSettingTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
              onTap: () {
                // Add logout logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context,
      {required IconData icon,
        required String title,
        String? subtitle,
        required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
