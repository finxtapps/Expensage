import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImageSection extends StatelessWidget {
  final String title;
  final File? imageFile;   // yeh add kiya

  const ProfileImageSection({
    super.key,
    required this.title,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Column(
        children: [
          // Profile image container
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? const Color(0xFFD44D5C) : Colors.white,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: imageFile == null
                  ? Container(
                color: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey,
                ),
              )
                  : Image.file(
                imageFile!,
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}














// import 'package:flutter/material.dart';
//
// class ProfileImageSection extends StatelessWidget {
//   final String title;
//   const ProfileImageSection({super.key,required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 2.0),
//       child: Column(
//         children: [
//           // Profile image
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color:isDarkMode ? Color(0xFFD44D5C) : Colors.white,
//                 width: 3,
//               ),
//             ),
//             child: ClipOval(
//               child: Container(
//                 color: Colors.grey[300],
//                 child: const Icon(
//                   Icons.person,
//                   size: 60,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           // Username
//            Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
