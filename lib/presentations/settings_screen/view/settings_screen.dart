import 'package:flutter/material.dart';
import 'package:notify/core/constants/global_textstyles.dart';
import '../../home_screen/widgets/privacypolicy.dart';
import '../../home_screen/widgets/support.dart';
import '../../home_screen/widgets/termsandconditions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: browntitle,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text('Terms and Conditions', style: subtextdark),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsAndConditionScreen(),
                  ));
            },
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.mail_outline_outlined,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text('Support', style: subtextdark),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupportScreen(),
                  ));
            },
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text('Privacy Policy', style: subtextdark),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
