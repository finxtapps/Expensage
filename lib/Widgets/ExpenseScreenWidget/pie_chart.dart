// widgets/pie_chart_widget.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uiproject/Widgets/ExpenseScreenWidget/time_filter_dropdown.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(

      padding: EdgeInsets.only(left:10.w,right: 10.w,bottom: .01.w),
      decoration: BoxDecoration(
        color:isDarkMode? Theme.of(context).colorScheme.primary : Colors.white,
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
          // Your pie chart implementation here

      Container(
        height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.only(left:6.w,right: 6.w,top: 4.w,),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(.2),
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
                'Categories',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color:isDarkMode? Colors.white: Colors.black87,
                ),
              ),
              Container(

                decoration: BoxDecoration(

                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: const TimeFilterDropdown(),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text(
                //       'Weekly',
                //       style: TextStyle(
                //         fontSize: 14.sp,
                //         color: Colors.black87,
                //       ),
                //     ),
                //     SizedBox(width: 4.w),
                //     Icon(
                //       Icons.keyboard_arrow_down,
                //       size: 16.sp,
                //       color: Colors.black87,
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
          SizedBox(height: .5.h),
          SizedBox(
            height: 260.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 80.r,
                    sections: [
                      PieChartSectionData(
                        color: const Color(0xFF3A9BBA),
                        value: 35,
                        title: '',
                        radius: 40.r,
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFFCDB2A),
                        value: 25,
                        title: '',
                        radius: 40.r,
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFFC2A76),
                        value: 40,
                        title: '',
                        radius: 40.r,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '-\$4500',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE57373),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: .1.h),
          Center(
            child: Text(
              'Tap on pie to see the details',
              style: TextStyle(
                fontSize: 13.sp,
                color:isDarkMode? Colors.white: Colors.grey,
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