import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeFilterDropdown extends StatefulWidget {
  final String selectedValue; // incoming selected filter
  final void Function(String)? onFilterChanged; // optional callback

  const TimeFilterDropdown({
    Key? key,
    required this.selectedValue,
    this.onFilterChanged,
  }) : super(key: key);

  @override
  _TimeFilterDropdownState createState() => _TimeFilterDropdownState();
}

class _TimeFilterDropdownState extends State<TimeFilterDropdown> {
  final List<String> _options = ['Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.06,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedValue,
          icon: Icon(Icons.keyboard_arrow_down, size: 16.sp, color: Colors.black87),
          items: _options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null && widget.onFilterChanged != null) {
              widget.onFilterChanged!(newValue);
            }
          },
        ),
      ),
    );
  }
}
