import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionTimeFilterDropdown extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String> onChanged;

  const TransactionTimeFilterDropdown({
    Key? key,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final List<String> options = ['Lifetime', 'Weekly', 'Monthly', 'Yearly', 'Date'];

    return Container(
      height: MediaQuery.of(context).size.width * 0.06,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500, width: 1.w),
        color:isDarkMode? Theme.of(context).colorScheme.primary: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedOption,
          icon: Icon(Icons.keyboard_arrow_down, size: 16.sp, color:isDarkMode? Colors.white: Colors.black87),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 14.sp, color:isDarkMode? Colors.white: Colors.black87),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue); // Notify parent
            }
          },
        ),
      ),
    );
  }
}
