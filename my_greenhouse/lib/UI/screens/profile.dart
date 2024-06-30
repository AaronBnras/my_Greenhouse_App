import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_greenhouse/UI/screens/widgets/custom_textfield.dart';
import 'package:my_greenhouse/UI/screens/widgets/profile_widget.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/services/firebase_authentication.dart';
import 'package:my_greenhouse/UI/screens/sign_in.dart';
import 'package:my_greenhouse/utils/string_extension.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  String _displayName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    setState(() {
      _displayName = _user?.displayName ?? 'No Name';
      _email = _user?.email ?? 'No Email';
    });
  }

  void _signOut(BuildContext context) async {
    final FirebaseAuthentication _auth = FirebaseAuthentication();

    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out. Please try again.')),
      );
    }
  }

  void _changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _currentPasswordController = TextEditingController();
        final TextEditingController _newPasswordController = TextEditingController();
        final TextEditingController _confirmPasswordController = TextEditingController();
        // final FirebaseAuthentication _auth = FirebaseAuthentication();

        return AlertDialog(
          title: Text('Change Password'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                customtextfield(
                  obscureText: true,
                  hintText: 'Current Password',
                  icon: Icons.lock,
                  controller: _currentPasswordController,
                ),
                customtextfield(
                  obscureText: true,
                  hintText: 'New Password',
                  icon: Icons.lock,
                  controller: _newPasswordController,
                ),
                customtextfield(
                  obscureText: true,
                  hintText: 'Confirm New Password',
                  icon: Icons.lock,
                  controller: _confirmPasswordController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                final currentPassword = _currentPasswordController.text.trim();
                final newPassword = _newPasswordController.text.trim();
                final confirmPassword = _confirmPasswordController.text.trim();

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New passwords do not match.')),
                  );
                  return;
                }

                try {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final cred = EmailAuthProvider.credential(
                      email: user.email!,
                      password: currentPassword,
                    );

                    await user.reauthenticateWithCredential(cred);
                    await user.updatePassword(newPassword);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password successfully updated.')),
                    );
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.primaryColor.withOpacity(.5),
                      width: 5.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: ExactAssetImage('assets/images/User.png'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * .3,
                  child: Row(
                    children: [
                      Text(
                        _displayName.capitalize(),
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                          height: 24,
                          child: Image.asset("assets/images/verified.png")),
                    ],
                  ),
                ),
                Text(
                  _email,
                  style: TextStyle(
                    color: Constants.blackColor.withOpacity(.3),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () => _changePassword(context),
                      ),
                      ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onTap: () => _signOut(context),
                        showArrow: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
