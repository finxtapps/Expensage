// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uiproject/Widgets/home_Screen_Widegets/transaction_list.dart';
import '../Widgets/ExpenseScreenWidget/bar_chart.dart';
import '../Widgets/ExpenseScreenWidget/pie_chart.dart';

class ExpenseAnalysisScreen extends StatefulWidget {
  const ExpenseAnalysisScreen({super.key});

  @override
  State<ExpenseAnalysisScreen> createState() => _ExpenseAnalysisScreenState();
}

class _ExpenseAnalysisScreenState extends State<ExpenseAnalysisScreen> {
  final int _selectedIndex = 0;

  @override

  Widget build(BuildContext context) {
    final int selectedIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:isDarkMode? Theme.of(context).colorScheme.primary: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BarChartWidget(),
              SizedBox(height: 10.h),
              const PieChartWidget(),
              SizedBox(height: 10.h),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    decoration:  BoxDecoration(
                      color: isDarkMode? Theme.of(context).colorScheme.primary : Colors.white,

                    ),
                    child:  const TransactionList(),
                  ),
                ),
              ),
              SizedBox(height: 100.h), // Space for bottom navigation
            ],
          ),
        ),
      ),
     // bottomNavigationBar: BottomNavBar(selectedIndex: selectedIndex),


    );
  }
}