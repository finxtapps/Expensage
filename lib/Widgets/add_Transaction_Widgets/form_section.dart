import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'input_field.dart';
import 'upload_button.dart';

class FormSection extends StatelessWidget {
  final TextEditingController itemController;
  final TextEditingController amountController;
  final XFile? selectedImage;
  final Future<void> Function() onPickImage;
  final VoidCallback onSave;

  const FormSection({
    super.key,
    required this.itemController,
    required this.amountController,
    required this.selectedImage,
    required this.onPickImage,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              InputField(
                icon: Icons.receipt_long_outlined,
                controller: itemController,
                hintText: 'Enter the item',
              ),
              const SizedBox(height: 30),
              InputField(
                icon: Icons.attach_money,
                controller: amountController,
                hintText: 'Enter the Amount',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 50),
              const Text(
                'Add invoice',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.16,
                width: double.infinity, // Use double.infinity for full width
                child: UploadButton(
                  selectedImage: selectedImage,
                  onPressed: onPickImage,
                ),
              ),
              if (selectedImage != null) _buildSelectedImageInfo(),
              const SizedBox(height: 20),
              _buildBottomButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImageInfo() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                Icons.image_outlined,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Expanded( // Use Expanded here
                child: Text(
                  selectedImage!.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded( // Use Expanded here
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              side: const BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  'Add more',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded( // Use Expanded here
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'input_field.dart';
// import 'upload_button.dart';
//
// class FormSection extends StatelessWidget {
//   final TextEditingController itemController;
//   final TextEditingController amountController;
//   final XFile? selectedImage;
//   final Future<void> Function() onPickImage;
//   final VoidCallback onSave;
//
//   const FormSection({
//     super.key,
//     required this.itemController,
//     required this.amountController,
//     required this.selectedImage,
//     required this.onPickImage,
//     required this.onSave,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     ///yaha  expended lga tha
//     return Padding(
//       padding:  const EdgeInsets.symmetric(horizontal: 35.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.white,
//           border: Border.all(color:Colors.black)
//         ),
//         padding:  const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),
//             InputField(
//               icon: Icons.receipt_long_outlined,
//               controller: itemController,
//               hintText: 'Enter the item',
//             ),
//             const SizedBox(height: 40),
//             InputField(
//               icon: Icons.attach_money,
//               controller: amountController,
//               hintText: 'Enter the Amount',
//
//               keyboardType: TextInputType.number,
//             ),
//             const SizedBox(height: 70),
//              const Text(
//               'Add invoice',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.16,
//               width: MediaQuery.of(context).size.height * 0.6,
//               child: UploadButton(
//                 selectedImage: selectedImage,
//                 onPressed: onPickImage,
//               ),
//             ),
//             if (selectedImage != null) _buildSelectedImageInfo(),
//              const Spacer(),
//             _buildBottomButtons(context),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSelectedImageInfo() {
//     return Column(
//       children: [
//          const SizedBox(height: 12),
//         Container(
//           padding:  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.image_outlined,
//                 size: 16,
//                 color: Colors.grey[600],
//               ),
//                const SizedBox(width: 8),
//               Flexible(
//                 fit:  FlexFit.loose,
//                 child: Text(
//                   selectedImage!.name,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Icon(
//                   Icons.close,
//                   size: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBottomButtons(context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Flexible(
//           fit:  FlexFit.loose,
//           child: OutlinedButton(
//             onPressed: () {},
//             style: OutlinedButton.styleFrom(
//               padding:  const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
//               side:  const BorderSide(
//                 color: Colors.black,
//                 width: 1.5,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.width * 0.08,
//               child: Center(
//                 child: Text(
//                   'Add more',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//          const SizedBox(width: 16),
//         Flexible(
//          fit:  FlexFit.loose,
//           child: ElevatedButton(
//             onPressed: onSave,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Theme.of(context).colorScheme.secondary,
//               padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 2,
//             ),
//             child:  SizedBox(
//               height: MediaQuery.of(context).size.width * 0.08,
//               child: Center(
//                 child: Text(
//                   'Save',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }