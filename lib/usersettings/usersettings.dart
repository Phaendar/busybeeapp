import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  bool _privateMode = true; // Default value
  bool _setting2 = false; // Default value
  String _selectedTimeLimit = 'Unlimited'; // Default value

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _privateMode = prefs.getBool('private_mode') ?? true;
      _setting2 = prefs.getBool('setting_2') ?? false;
      final int minutes =
          prefs.getInt('daily_limit') ?? -1; // Default to 'Unlimited'
      if (minutes == -1) {
        _selectedTimeLimit = 'Unlimited';
      } else if (minutes == 30) {
        _selectedTimeLimit = '30 Mins';
      } else if (minutes == 60) {
        _selectedTimeLimit = '1 Hour';
      } else if (minutes == 120) {
        _selectedTimeLimit = '2 Hours';
      }
    });
  }

  Future<void> _savePrivateMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('private_mode', value);
  }

  Future<void> _saveSetting2(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setting_2', value);
  }

  Future<void> _saveTimeLimit(String limit) async {
    final prefs = await SharedPreferences.getInstance();
    int minutes;
    switch (limit) {
      case '30 Mins':
        minutes = 30;
        break;
      case '1 Hour':
        minutes = 60;
        break;
      case '2 Hours':
        minutes = 120;
        break;
      default: // 'Unlimited'
        minutes = -1;
        break;
    }
    await prefs.setInt('daily_limit', minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Private Mode'),
            trailing: Switch(
              value: _privateMode,
              onChanged: (value) {
                setState(() {
                  _privateMode = value;
                });
                _savePrivateMode(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Setting 2'),
            trailing: Switch(
              value: _setting2,
              onChanged: (value) {
                setState(() {
                  _setting2 = value;
                });
                _saveSetting2(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Time Limit'),
            trailing: DropdownButton<String>(
              value: _selectedTimeLimit,
              onChanged: (value) {
                setState(() {
                  _selectedTimeLimit = value!;
                });
                _saveTimeLimit(value!);
              },
              items: <String>['Unlimited', '30 Mins', '1 Hour', '2 Hours']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // This button can now be used for a general 'Save' functionality if required,
              // but the individual settings are saved immediately upon change.
            },
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }
}
