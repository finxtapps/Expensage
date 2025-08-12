import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiproject/Screens/SignUpScreen.dart';
import 'package:uiproject/Screens/splash_Screen.dart';
import 'package:uiproject/Widgets/home_Screen_Widegets/new_BottomBar.dart' hide AddTransactionScreen;
import 'package:uiproject/theme/theme_provider.dart';



import 'Screens/Landing_page.dart';
import 'Screens/Select_Location_Screen.dart';
import 'Screens/create_Pin_Screen.dart';
import 'Screens/currency_select_Screen.dart';
import 'Screens/expense_analysis_screen.dart';

import 'Screens/login_Screen.dart';
import 'Screens/notification_Screen.dart';
import 'Screens/scan_Fingerprint_screen.dart';
import 'Screens/set_pin_and_fingerprint_Screen.dart';
import 'Screens/personal_information.dart';
import 'Screens/profile_Information.dart';
import 'Screens/setting_Screen.dart';
import 'Screens/wrapper.dart';




// main.dart


void main() async {
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && message.length > 300) {
      print('${message.substring(0, 300)}... [truncated]');
    } else {
      print("/n================================================================================================== ${message.toString()}/n");
    }

  };
  debugPrintRebuildDirtyWidgets = true;
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('selectedTheme') ?? 'Pink';

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(initialTheme: savedTheme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 812), // ✅ Use design size of your figma
          minTextAdapt: true,

          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(

              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,

              routes: {
               '/': (context) => SplashScreen(),//1
                '/landingpage' :(context)=>  LandingPage(),//SignUpScreen(),//2
                '/analytics': (context) =>  ExpenseAnalysisScreen(),//3
                '/home': (context) =>  MainScreenWrapper(),//4
                '/notification':(context)=> NotificationsScreen(),//5
                '/personal':(context) =>   PersonalInformation(),//6
                '/profile': (context) =>  ProfileInfoScreen(),//7
                '/settings': (context) =>  SettingsScreen(),//8
                '/signin':(context)=> SignInScreen(),//9
                '/signup':(context) =>  SignUpScreen(),//10
                '/currency_select': (context) =>  CurrencySelectScreen(),//11
                '/pin': (context) =>  MpinScreen(),//12
                '/set_pin_and_fingerprint': (context) =>  SetPinAndFingerprintScreen(),//13'
                '/location': (context) =>  LocationScreen(),//15'
                '/fingerprint': (context) =>  ScanFingerprintScreen(),//17
               // 'addTransaction': (context) =>  AddTransactionScreen(),//18

              },
            );
          },
        );
      },
    );
  }
}




