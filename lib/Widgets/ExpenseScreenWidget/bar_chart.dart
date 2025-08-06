// widgets/bar_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uiproject/Widgets/ExpenseScreenWidget/time_filter_dropdown.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});


  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFD44D5C),
          width: 24.w,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
      decoration: BoxDecoration(
        color:isDarkMode? Theme.of(context).colorScheme.primary :Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your bar chart implementation here

      Container(
      padding: EdgeInsets.only(left:6.w,right: 6.w),
      decoration: BoxDecoration(
        color:isDarkMode?Theme.of(context).colorScheme.primary :Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How much you spend?',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color:isDarkMode? Colors.white: Colors.black87,
                ),
              ),
              Container(

                decoration: BoxDecoration(
                  border: Border.all(color:isDarkMode? Colors.white: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child:
                //Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                    const TimeFilterDropdown(),
                    // Text(
                    //   'Weekly',
                    //   style: TextStyle(
                    //     fontSize: 14.sp,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                    // SizedBox(width: 4.w),
                    // Icon(
                    //   Icons.keyboard_arrow_down,
                    //   size: 16.sp,
                    //   color: Colors.black87,
                    // ),
                //   ],
                // ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            decoration: BoxDecoration(

              border: Border.all(color:isDarkMode? Colors.white: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(12.r),

            ),
            child: Padding(
              padding:  EdgeInsets.only(top: 10.h,left: 5.r),
              child: SizedBox(

                height: 200.h,
                child: BarChart(

                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 4000,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            return Text(
                              days[value.toInt()],
                              style: TextStyle(
                                fontSize: 12.sp,
                                color:isDarkMode? Colors.white: Colors.black54,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40.w,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '\$${(value / 1000).toStringAsFixed(1)}K',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color:isDarkMode? Colors.white: Colors.black54,
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _buildBarGroup(0, 1500),
                      _buildBarGroup(1, 2000),
                      _buildBarGroup(2, 1200),
                      _buildBarGroup(3, 2500),
                      _buildBarGroup(4, 1800),
                      _buildBarGroup(5, 3200),
                      _buildBarGroup(6, 3600),
                    ],
                    gridData: const FlGridData(show: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
        ],
      ),
    );
  }
}