import 'package:flutter/material.dart';

import '../Widgets/profile_Info_Screen_Widgets/header_section.dart';
import '../Widgets/profile_Info_Screen_Widgets/menu_item.dart';


class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final int selectedIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          color: isDarkMode? Colors.black:Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              SizedBox(

                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ProfileHeaderSection(onBackPressed: () => Navigator.pop(context)),
                              SizedBox(
                                height: 5,
                              ),

                              Padding(
                                padding: EdgeInsets.only(

                                    top:MediaQuery.of(context).size.height * 0.265,
                                    left: MediaQuery.of(context).size.width * 0.09,
                                    right: MediaQuery.of(context).size.width * 0.09,
                                ),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode? Colors.black:Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 30),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, '/personal');
                                            },
                                            child: MenuItem(
                                              icon: Icons.person,
                                              title: 'Personal Information',
                                              onTap: () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Personal Information tapped')),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          MenuItem(
                                            icon: Icons.diamond,
                                            title: 'Invite friends',
                                            onTap: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Invite friends tapped')),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          MenuItem(
                                            icon: Icons.people,
                                            title: 'Rate us',
                                            onTap: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Rate us tapped')),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          MenuItem(
                                            icon: Icons.logout,
                                            title: 'Log out',
                                            onTap: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Log out tapped')),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                   // BottomNavBar(selectedIndex: selectedIndex),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}