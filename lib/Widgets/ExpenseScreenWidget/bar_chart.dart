import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../component/time_filter.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  String selectedFilter = 'Weekly';
  DateTime? selectedDate;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      format: 'point.x : \$point.y',
      canShowMarker: false,
      textStyle: const TextStyle(color: Colors.white),
    );
  }

  /// 🔥 Chart Data Generator
  List<_ChartData> _getChartData() {
    DateTime now = DateTime.now();

    if (selectedFilter == 'Lifetime') {
      int currentYear = now.year;
      int previousYear = now.year - 1;

      return [
        _ChartData(previousYear.toString(), 45000),
        _ChartData(currentYear.toString(), 52000),
      ];
    }

    if (selectedFilter == 'Monthly') {
      return List.generate(30, (index) {
        DateTime date = now.subtract(Duration(days: 29 - index));
        String day = DateFormat('dd MMM').format(date);
        double value = (1000 + (index * 150)).toDouble();
        return _ChartData(day, value);
      });
    }

    if (selectedFilter == 'Yearly') {
      return List.generate(now.month, (index) {
        String month = DateFormat('MMM').format(DateTime(now.year, index + 1));
        double value = (3000 + (index * 800)).toDouble();
        return _ChartData(month, value);
      });
    }

    if (selectedFilter == 'Date' && selectedDate != null) {
      return List.generate(6, (index) {
        String slot = "${(index + 1) * 4}h"; // 4h slots
        double value = (500 + (index * 200)).toDouble();
        return _ChartData(slot, value);
      });
    }

    // Default → Weekly
    final values = [1500, 2000, 1200, 2500, 1800, 3200, 3600];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return List.generate(values.length, (index) {
      return _ChartData(days[index], values[index].toDouble());
    });
  }

  /// 🔥 Calculate max Y dynamically
  double _getMaxY(List<_ChartData> data) {
    if (data.isEmpty) return 1000; // fallback if no data
    double maxVal = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    return maxVal + (maxVal * 0.2); // 20% extra space
  }

  /// 🔥 Date picker for "Date" filter
  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedFilter = 'Date';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final chartData = _getChartData();
    final maxY = _getMaxY(chartData);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child:Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isDarkMode
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(.2),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     spreadRadius: 1,
        //     blurRadius: 10,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How much you spend?',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              TransactionTimeFilterDropdown(
                selectedOption: selectedFilter,
                onChanged: (newValue) async {
                  if (newValue == 'Date') {
                    await _pickDate();
                  } else {
                    setState(() {
                      selectedDate = null;
                      selectedFilter = newValue;
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Chart
          SizedBox(
            height: 250.h,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              tooltipBehavior: _tooltipBehavior,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelRotation:
                (selectedFilter == 'Monthly' || selectedFilter == 'Date')
                    ? -45
                    : 0,
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black54,
                  fontSize: 10.sp,
                ),
              ),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0.3),
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black54,
                  fontSize: 10.sp,
                ),
                labelFormat: '\${value}',
                interval: (maxY > 0)
                    ? (maxY / 5).clamp(1, double.infinity)
                    : 1,
                maximum: (maxY > 0) ? maxY : 1000,
              ),
              series: <CartesianSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.day,
                  yValueMapper: (_ChartData data, _) => data.amount,
                  borderRadius: BorderRadius.circular(6.r),
                  color: const Color(0xFFD44D5C),
                  width: 0.6,
                  animationDuration: 1200, // ✅ enable animation here
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _ChartData {
  final String day;
  final double amount;
  _ChartData(this.day, this.amount);
}


















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../component/time_filter.dart';
//
// class BarChartWidget extends StatefulWidget {
//   const BarChartWidget({Key? key}) : super(key: key);
//
//   @override
//   State<BarChartWidget> createState() => _BarChartWidgetState();
// }
//
// class _BarChartWidgetState extends State<BarChartWidget>
//     with SingleTickerProviderStateMixin {
//   String selectedFilter = 'Weekly';
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   final Map<String, List<double>> filterData = {
//     'Lifetime': [3000, 2500, 2800, 3500, 4000, 3700, 3900],
//     'Weekly': [1500, 2000, 1200, 2500, 1800, 3200, 3600],
//     'Monthly': [2000, 2300, 2100, 2400, 2600, 2800, 3000],
//     'Yearly': [2500, 2700, 3000, 3200, 3300, 3500, 3700],
//   };
//
//   final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       header: '',
//       format: 'point.x : \$point.y',
//       canShowMarker: false,
//       textStyle: const TextStyle(color: Colors.white),
//     );
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     );
//
//     // Trigger animation when widget appears
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _controller.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   List<_ChartData> _getChartData() {
//     final values = filterData[selectedFilter]!;
//     return List.generate(values.length, (index) {
//       return _ChartData(days[index], values[index] * _animation.value);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
//           decoration: BoxDecoration(
//             color: isDarkMode
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 6.w, right: 6.w),
//                 decoration: BoxDecoration(
//                   color: isDarkMode
//                       ? Theme.of(context).colorScheme.primary
//                       : Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     /// Header row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'How much you spend?',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                             color: isDarkMode ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                         TransactionTimeFilterDropdown(
//                           selectedOption: selectedFilter,
//                           onChanged: (newValue) {
//                             setState(() {
//                               selectedFilter = newValue;
//                               _controller.reset();
//                               _controller.forward();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//
//                     /// Chart
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: isDarkMode
//                               ? Colors.white
//                               : Colors.grey.shade500,
//                         ),
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: SizedBox(
//                         height: 200.h,
//                         child: SfCartesianChart(
//                           plotAreaBorderWidth: 0,
//                           tooltipBehavior: _tooltipBehavior,
//                           primaryXAxis: CategoryAxis(
//                             majorGridLines: const MajorGridLines(width: 0),
//                             labelStyle: TextStyle(
//                               color: isDarkMode ? Colors.white : Colors.black54,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                           primaryYAxis: NumericAxis(
//                             axisLine: const AxisLine(width: 0),
//                             majorGridLines: const MajorGridLines(width: 0.3),
//                             labelStyle: TextStyle(
//                               color: isDarkMode ? Colors.white : Colors.black54,
//                               fontSize: 10.sp,
//                             ),
//                             labelFormat: '\${value}K',
//                             interval: 1000,
//                             maximum: 4000,
//                           ),
//                           series: <CartesianSeries<_ChartData, String>>[
//                             ColumnSeries<_ChartData, String>(
//                               dataSource: _getChartData(),
//                               xValueMapper: (_ChartData data, _) => data.day,
//                               yValueMapper: (_ChartData data, _) => data.amount,
//                               borderRadius: BorderRadius.circular(6.r),
//                               color: const Color(0xFFD44D5C),
//                               width: 0.6,
//                               animationDuration: 0, // disable built-in animation
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _ChartData {
//   final String day;
//   final double amount;
//   _ChartData(this.day, this.amount);
// }
//
