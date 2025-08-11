import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';

class SetPinAndFingerprintScreen extends StatelessWidget {
  const SetPinAndFingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
              themeProvider.currentTheme == 'Pink'
                  ? HeaderColor.pinkGradient
                  : themeProvider.currentTheme == 'Green'
                  ? HeaderColor.greenGradient
                  : themeProvider.currentTheme == 'Blue'
                  ? HeaderColor.blueGradient
                  : themeProvider.currentTheme == 'Orange'
                  ? HeaderColor.orangeGradient
                  : HeaderColor.darkGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding:  const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/pin');
            },
            child: _buildContentBox(context,
              title: 'PIN',
              subtitle: 'Set four digit pin',
              icon: Icons.arrow_forward_ios,
            ),
          ),

          _buildContentBox(context,
              title: "Fingerprint",
              subtitle: "Scan and save your fingerprint",
              icon: Icons.arrow_forward_ios),
        ],
      ),
    );
  }
  Widget _buildContentBox(BuildContext context, {

    required String title,
    required String subtitle,
    required IconData icon,
  }){
    return Padding(
      padding:  EdgeInsets.symmetric(
          horizontal:MediaQuery.of(context).size.width*.1,
          vertical:MediaQuery.of(context).size.height*.04
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.bold),),
                    Text(subtitle,style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                  ],
                ),
                Icon(icon,color: Colors.grey,),
              ],
            ),
          )
        ],
      ),
    );

  }
}


