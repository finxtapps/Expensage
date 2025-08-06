import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  const InputField({
    super.key,
    required this.icon,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.black,
            size: 36,
          ),
        ),
        const SizedBox(width: 16),
        Expanded( // Use Expanded instead of Flexible
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEF5350), width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}






















// import 'package:flutter/material.dart';
//
// class InputField extends StatelessWidget {
//   final IconData icon;
//   final TextEditingController controller;
//   final String hintText;
//   final TextInputType? keyboardType;
//
//   const InputField({
//     super.key,
//     required this.icon,
//     required this.controller,
//     required this.hintText,
//     this.keyboardType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.primary.withOpacity(.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             icon,
//             color: Colors.black,
//             size: 36,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Flexible(
//           fit:  FlexFit.loose,
//           child: TextField(
//             controller: controller,
//             keyboardType: keyboardType,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//               border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: const UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFFEF5350), width: 2),
//               ),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               contentPadding: const EdgeInsets.symmetric(vertical: 12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
