import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadButton extends StatelessWidget {
  final XFile? selectedImage;
  final Future<void> Function() onPressed;

  const UploadButton({
    super.key,
    required this.selectedImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7, // Adjust width as needed
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedImage != null ? const Color(0xFFEF5350) : Colors.grey[400]!,
            style: BorderStyle.solid,
            width: selectedImage != null ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: selectedImage != null ? const Color(0XFFD44D5C).withOpacity(0.05) : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              await onPressed();
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    selectedImage != null ? Icons.check_circle_outline : Icons.upload_outlined,
                    color: selectedImage != null ? const Color(0xFFEF5350) : Colors.black87,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    selectedImage != null ? 'Invoice selected' : 'Upload invoice',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: selectedImage != null ? const Color(0xFFEF5350) : Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadButton extends StatelessWidget {
//   final XFile? selectedImage;
//   final Future<void> Function() onPressed;
//
//   const UploadButton({
//     super.key,
//     required this.selectedImage,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.7,
//         height: 56,
//         decoration: BoxDecoration(
//
//           border: Border.all(
//             color: selectedImage != null ? const Color(0xFFEF5350) : Colors.grey[400]!,
//             style: BorderStyle.solid,
//             width: selectedImage != null ? 2 : 1.5,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           color: selectedImage != null ? const Color(0XFFD44D5C).withOpacity(0.05) : Colors.transparent,
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () async {
//               HapticFeedback.lightImpact();
//               await onPressed();
//             },
//             borderRadius: BorderRadius.circular(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   selectedImage != null ? Icons.check_circle_outline : Icons.upload_outlined,
//                   color: selectedImage != null ? const Color(0xFFEF5350) : Colors.black87,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   selectedImage != null ? 'Invoice selected' : 'Upload invoice',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: selectedImage != null ? const Color(0xFFEF5350) : Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
