import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = true;
  String _quality = 'High';
  bool _analyticsEnabled = true;
  String _language = 'English';

  void _clearCache() {
    // Placeholder for actual cache clearing logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cache cleared')));
  }

  void _logout() {
    // Placeholder for logout logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Get notified about new releases'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Toggle dark/light theme'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          ListTile(
            title: Text('Streaming Quality'),
            subtitle: Text(_quality),
            trailing: DropdownButton<String>(
              value: _quality,
              items: ['Low', 'Medium', 'High']
                  .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                  .toList(),
              onChanged: (value) => setState(() => _quality = value!),
            ),
          ),
          SwitchListTile(
            title: Text('Enable Analytics'),
            subtitle: Text('Help us improve the app by sending analytics data'),
            value: _analyticsEnabled,
            onChanged: (value) => setState(() => _analyticsEnabled = value),
          ),
          ListTile(
            title: Text('Language'),
            subtitle: Text(_language),
            trailing: Icon(Icons.language),
            onTap: () {
              // Show language selection dialog or navigate to language settings
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: ['English', 'Spanish', 'French', 'German']
                        .map((language) => RadioListTile<String>(
                      value: language,
                      groupValue: _language,
                      title: Text(language),
                      onChanged: (value) {
                        setState(() {
                          _language = value!;
                        });
                        Navigator.pop(context);
                      },
                    ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Clear Cache'),
            trailing: Icon(Icons.cleaning_services),
            onTap: _clearCache,
          ),
          ListTile(
            title: Text('About'),
            trailing: Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Movie App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Movie App',
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Account Settings'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Navigate to Account Settings screen
              Navigator.push(context, MaterialPageRoute(builder: (_) => AccountSettingsScreen()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: _logout,
          ),
          Divider(),
          ListTile(
            title: Text('Feedback'),
            leading: Icon(Icons.feedback),
            onTap: () {
              // Show feedback dialog or navigate to feedback form
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Feedback'),
                  content: TextField(
                    decoration: InputDecoration(hintText: 'Enter your feedback...'),
                    maxLines: 3,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle feedback submission
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted')));
                        Navigator.pop(context);
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Password'),
            leading: Icon(Icons.lock),
            onTap: () {
              // Navigate to Change Password screen or show a dialog
            },
          ),
          ListTile(
            title: Text('Profile Information'),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to Profile Information screen
            },
          ),
        ],
      ),
    );
  }
}
