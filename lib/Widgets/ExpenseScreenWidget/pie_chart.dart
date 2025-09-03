import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import '../../component/time_filter.dart';

class RadialChartWidget extends StatefulWidget {
  final bool active;
  const RadialChartWidget({super.key, this.active = false});

  @override
  State<RadialChartWidget> createState() => _RadialChartWidgetState();
}

class _RadialChartWidgetState extends State<RadialChartWidget>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'Lifetime';
  DateTime? _selectedDate;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  /// Dummy chart data
  final Map<String, List<double>> _chartData = {
    'Lifetime': [70, 55, 30, 80],
    'Weekly': [35, 63, 25, 40],
    'Monthly': [45, 30, 69, 25],
    'Yearly': [88, 60, 15, 25],
  };

  /// Dummy date-wise data
  final Map<String, List<double>> _dateChartData = {
    '2025-09-01': [40, 20, 70, 50],
    '2025-09-02': [55, 45, 30, 80],
    '2025-09-03': [65, 25, 50, 40],
  };

  final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.active) _startAnimation();
    });
  }

  @override
  void didUpdateWidget(covariant RadialChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.forward(from: 0);
  }

  List<_ChartData> _getChartData() {
    List<double> values = [];

    if (_selectedFilter == 'Date' && _selectedDate != null) {
      final key = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      values = _dateChartData[key] ?? [0, 0, 0, 0];
    } else {
      values = _chartData[_selectedFilter]!;
    }

    return List.generate(values.length, (i) {
      double animatedValue = values[i] * _animation.value;
      if (animatedValue < 0.1) animatedValue = 0.1;
      return _ChartData(
        'Category ${i + 1}',
        animatedValue,
        _colors[i % _colors.length],
      );
    });
  }

  /// ✅ Custom Date Picker
  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: now, // ✅ Future date disable
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDarkMode
                ? ColorScheme.dark(
              primary: Colors.orange, // ✅ current date highlight
              onPrimary: Colors.white, // ✅ text color on highlighted date
              surface: Colors.grey[900]!,
              onSurface: Colors.white, // ✅ default text
            )
                : ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: isDarkMode
                    ? Colors.white // ✅ OK/Cancel button text white in dark mode
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedFilter = 'Date';
        _startAnimation();
      });
    } else {
      // Cancel karne par Lifetime default
      setState(() {
        _selectedFilter = 'Lifetime';
        _selectedDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final chartData = _getChartData();

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
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 260.h,
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        TransactionTimeFilterDropdown(
                          selectedOption: _selectedFilter,
                          onChanged: (value) async {
                            if (value == 'Date') {
                              await _pickDate(); // ✅ ab custom function call
                            } else {
                              setState(() {
                                _selectedFilter = value;
                                _selectedDate = null;
                                _startAnimation();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SfRadialGauge(
                            axes: List.generate(chartData.length, (i) {
                              return RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                startAngle: 0,
                                endAngle: 360,
                                showTicks: false,
                                showLabels: false,
                                radiusFactor: 0.9 - (i * 0.13),
                                axisLineStyle: AxisLineStyle(
                                  thickness: 8.r,
                                  color: isDarkMode
                                      ? Colors.white12
                                      : Colors.grey[300],
                                  cornerStyle: CornerStyle.bothCurve,
                                ),
                                pointers: [
                                  RangePointer(
                                    value: chartData[i].value,
                                    cornerStyle: CornerStyle.bothCurve,
                                    width: 8.r,
                                    color: chartData[i].color,
                                    enableAnimation: true,
                                    animationDuration: 900,
                                  )
                                ],
                              );
                            }),
                          ),
                          Center(
                            child: Text(
                              '-\$4500',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE57373),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}




























// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import '../../component/time_filter.dart';
//
// class RadialChartWidget extends StatefulWidget {
//   final bool active;
//   const RadialChartWidget({super.key, this.active = false});
//
//   @override
//   State<RadialChartWidget> createState() => _RadialChartWidgetState();
// }
//
// class _RadialChartWidgetState extends State<RadialChartWidget>
//     with SingleTickerProviderStateMixin {
//   String _selectedFilter = 'Lifetime';
//
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   final Map<String, List<double>> _chartData = {
//     'Lifetime': [70, 55, 30,80],
//     'Weekly': [35, 63,25, 40],
//     'Monthly': [45, 30,69, 25],
//     'Yearly': [88,60, 15, 25],
//    // 'Date': [20, 50, 30,55],
//   };
//
//   final List<Color> _colors = [
//     Colors.blue,
//     Colors.green,
//     Colors.purple,
//     Colors.pink,
//
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     );
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.active) _startAnimation();
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant RadialChartWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.active && !oldWidget.active) {
//       _startAnimation();
//     }
//   }
//
//   void _startAnimation() {
//     _controller.forward(from: 0);
//   }
//
//   List<_ChartData> _getChartData(String filter) {
//     final values = _chartData[filter]!;
//     return List.generate(values.length, (i) {
//       double animatedValue = values[i] * _animation.value;
//       if (animatedValue < 0.1) animatedValue = 0.1;
//       return _ChartData(
//         'Category ${i + 1}',
//         animatedValue,
//         _colors[i % _colors.length],
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, _) {
//         final chartData = _getChartData(_selectedFilter);
//
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           decoration: BoxDecoration(
//             color: isDarkMode
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 offset:  Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 260.h,
//                 padding: EdgeInsets.all(6.w),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(.2),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Categories',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                             color: isDarkMode ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                         TransactionTimeFilterDropdown(
//                           selectedOption: _selectedFilter,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedFilter = value;
//                               _startAnimation();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Expanded(
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SfRadialGauge(
//                             axes: List.generate(chartData.length, (i) {
//                               return RadialAxis(
//                                 minimum: 0,
//                                 maximum: 100,
//                                 startAngle: 0,
//                                 endAngle: 360,
//                                 showTicks: false,
//                                 showLabels: false,
//                                 radiusFactor: 0.9 - (i * 0.13), // inner rings smaller
//                                 axisLineStyle: AxisLineStyle(
//                                   thickness: 8.r,
//                                   color: isDarkMode
//                                       ? Colors.white12
//                                       : Colors.grey[300],
//                                   cornerStyle: CornerStyle.bothCurve,
//                                 ),
//                                 pointers: [
//                                   RangePointer(
//                                     value: chartData[i].value,
//                                     cornerStyle: CornerStyle.bothCurve,
//                                     width: 8.r,
//                                     color: chartData[i].color,
//                                     enableAnimation: true,
//                                     animationDuration: 900,
//                                   )
//                                 ],
//                               );
//                             }),
//                           ),
//                           Center(
//                             child: Text(
//                               '-\$4500',
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color(0xFFE57373),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
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
//   _ChartData(this.category, this.value, this.color);
//   final String category;
//   final double value;
//   final Color color;
// }













// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../component/time_filter.dart';
//
// /// Global counter for ExpenseAnalysisScreen visits
// // int expenseScreenVisitCount = 0;
//
// class PieChartWidget extends StatefulWidget {
//   final bool active; // true if this tab is active
//   const PieChartWidget({super.key, this.active = false});
//
//   @override
//   State<PieChartWidget> createState() => _PieChartWidgetState();
// }
//
// class _PieChartWidgetState extends State<PieChartWidget>
//     with SingleTickerProviderStateMixin {
//   String _selectedFilter = 'Lifetime';
//
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   final Map<String, List<PieChartSectionData>> _chartData = {
//     'Lifetime': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//     'Weekly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 35, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 25, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 40, title: '', radius: 40),
//     ],
//     'Monthly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 45, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 30, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Yearly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 60, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 15, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Date': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     );
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.active) _incrementCount();
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant PieChartWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.active && !oldWidget.active) {
//       _incrementCount();
//     }
//   }
//
//   void _incrementCount() {
//     setState(() {
//       //expenseScreenVisitCount++;
//     });
//     _startAnimation();
//   }
//
//   void _startAnimation() {
//     _controller.forward(from: 0);
//   }
//
//   List<PieChartSectionData> _animatedSections(String filter) {
//     final realSections = _chartData[filter]!;
//     final totalValue = realSections.fold<double>(0, (sum, item) => sum + item.value);
//
//     double animatedTotal = totalValue * _animation.value;
//
//     return realSections.map((section) {
//       double newValue = section.value;
//       if (animatedTotal < section.value) newValue = animatedTotal;
//       animatedTotal -= section.value;
//       if (animatedTotal < 0) animatedTotal = 0;
//
//       return PieChartSectionData(
//         color: section.color,
//         value: newValue.clamp(0, section.value),
//         title: '',
//         radius: section.radius,
//       );
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, _) {
//         return Container(
//           padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 0.01.w),
//           decoration: BoxDecoration(
//             color: isDarkMode ? Theme.of(context).colorScheme.primary : Colors.white,
//             borderRadius: BorderRadius.circular(12.r),
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
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 padding: EdgeInsets.all(6.w),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(.2),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Categories',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                             color: isDarkMode ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                         // Text(
//                         //   expenseScreenVisitCount.toString(),
//                         //   style: TextStyle(
//                         //       fontSize: 16.sp,
//                         //       fontWeight: FontWeight.bold,
//                         //       color: Colors.red),
//                         // ),
//                         TransactionTimeFilterDropdown(
//                           selectedOption: _selectedFilter,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedFilter = value;
//                               _startAnimation();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 0.5.h),
//                     SizedBox(
//                       height: 260.h,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           PieChart(
//                             PieChartData(
//                               sectionsSpace: 2,
//                               centerSpaceRadius: 80.r,
//                               sections: _animatedSections(_selectedFilter),
//                             ),
//                           ),
//                           Text(
//                             '-\$4500',
//                             style: TextStyle(
//                               fontSize: 30.sp,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFFE57373),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     Center(
//                       child: Text(
//                         'Tap on pie to see the details',
//                         style: TextStyle(
//                           fontSize: 13.sp,
//                           color: isDarkMode ? Colors.white : Colors.grey,
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
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../component/time_filter.dart';
//
// // Create this globally in main.dart
// final RouteObserver<ModalRoute<void>> routeObserver =
// RouteObserver<ModalRoute<void>>();
//
// class PieChartWidget extends StatefulWidget {
//   const PieChartWidget({super.key});
//
//   @override
//   State<PieChartWidget> createState() => _PieChartWidgetState();
// }
//
// class _PieChartWidgetState extends State<PieChartWidget>
//     with SingleTickerProviderStateMixin, RouteAware {
//   String _selectedFilter = 'Lifetime';
//
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   final Map<String, List<PieChartSectionData>> _chartData = {
//     'Lifetime': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//     'Weekly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 35, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 25, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 40, title: '', radius: 40),
//     ],
//     'Monthly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 45, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 30, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Yearly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 60, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 15, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Date': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     );
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)!);
//   }
//
//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didPush() {
//     _startAnimation();
//   }
//
//   @override
//   void didPopNext() {
//     _startAnimation();
//   }
//
//   void _startAnimation() {
//     _controller.forward(from: 0);
//   }
//
//   List<PieChartSectionData> _animatedSections(String filter) {
//     final realSections = _chartData[filter]!;
//     final totalValue = realSections.fold<double>(0, (sum, item) => sum + item.value);
//
//     double animatedTotal = totalValue * _animation.value;
//
//     return realSections.map((section) {
//       // proportionally reduce section value based on animation progress
//       double newValue = section.value;
//       if (animatedTotal < section.value) {
//         newValue = animatedTotal; // partial fill
//       }
//       animatedTotal -= section.value;
//       if (animatedTotal < 0) animatedTotal = 0;
//
//       return PieChartSectionData(
//         color: section.color,
//         value: newValue.clamp(0, section.value),
//         title: '',
//         radius: section.radius,
//       );
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double count=0;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, _) {
//         return Container(
//           padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 0.01.w),
//           decoration: BoxDecoration(
//             color: isDarkMode
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(12.r),
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
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 padding: EdgeInsets.all(6.w),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primary.withOpacity(.2),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Categories',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w600,
//                             color: isDarkMode ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                         Text(count.toString()),
//                         TransactionTimeFilterDropdown(
//                           selectedOption: _selectedFilter,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedFilter = value;
//                               _startAnimation();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 0.5.h),
//                     SizedBox(
//                       height: 260.h,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           PieChart(
//                             PieChartData(
//                               sectionsSpace: 2,
//                               centerSpaceRadius: 80.r,
//                               sections: _animatedSections(_selectedFilter),
//                             ),
//                           ),
//                           Text(
//                             '-\$4500',
//                             style: TextStyle(
//                               fontSize: 30.sp,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFFE57373),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//
//                     Center(
//                       child: Text(
//                         'Tap on pie to see the details',
//                         style: TextStyle(
//                           fontSize: 13.sp,
//                           color: isDarkMode ? Colors.white : Colors.grey,
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

//
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../component/time_filter.dart';
//
//
// class PieChartWidget extends StatefulWidget {
//   const PieChartWidget({super.key});
//
//   @override
//   State<PieChartWidget> createState() => _PieChartWidgetState();
// }
//
// class _PieChartWidgetState extends State<PieChartWidget> {
//   String _selectedFilter = 'Weekly';
//
//   // Sample data for each filter type
//   final Map<String, List<PieChartSectionData>> _chartData = {
//     'Lifetime': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//     'Weekly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 35, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 25, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 40, title: '', radius: 40),
//     ],
//     'Monthly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 45, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 30, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Yearly': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 60, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 15, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 25, title: '', radius: 40),
//     ],
//     'Date': [
//       PieChartSectionData(color: Color(0xFF3A9BBA), value: 20, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFCDB2A), value: 50, title: '', radius: 40),
//       PieChartSectionData(color: Color(0xFFFC2A76), value: 30, title: '', radius: 40),
//     ],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 0.01.w),
//       decoration: BoxDecoration(
//         color: isDarkMode ? Theme.of(context).colorScheme.primary : Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.4,
//             padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.w),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary.withOpacity(.2),
//               borderRadius: BorderRadius.circular(12.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 10,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title + Filter Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Categories',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                         color: isDarkMode ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                     TransactionTimeFilterDropdown(
//                       selectedOption: _selectedFilter,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedFilter = value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 0.5.h),
//
//                 // Pie Chart
//                 SizedBox(
//                   height: 260.h,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       PieChart(
//                         PieChartData(
//                           sectionsSpace: 2,
//                           centerSpaceRadius: 80.r,
//                           sections: _chartData[_selectedFilter]!,
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             '-\$4500',
//                             style: TextStyle(
//                               fontSize: 30.sp,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFFE57373),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 0.1.h),
//
//                 // Hint Text
//                 Center(
//                   child: Text(
//                     'Tap on pie to see the details',
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: isDarkMode ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
