// import 'dart:io';

// import 'package:butterflix/common_widgets/custom_buttons.dart';
// import 'package:butterflix/common_widgets/image_pick.dart';
// import 'package:butterflix/utils/app_colors.dart';
// import 'package:flutter/material.dart';

// class _BottomSheetContent extends StatefulWidget {
//   final String name;
//   final String email;

//   _BottomSheetContent({required this.name, required this.email});

//   @override
//   _BottomSheetContentState createState() => _BottomSheetContentState();
// }

// class _BottomSheetContentState extends State<_BottomSheetContent> {
//  bool _isEditingName = false;
//   bool _isEditingEmail = false;
//   bool _isEditingPassword = false;
//   TextEditingController nameController = TextEditingController();
//    FocusNode nameFocusNode = FocusNode();
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode passwordFocusNode = FocusNode();// FocusNode to control focus



//   TextEditingController emailController = new TextEditingController();

//   TextEditingController passController = new TextEditingController();

//   final List<String> genres = [
//     "🎭 Drama",
//     "🎬 Action",
//     "😂 Comedy",
//     "👻 Horror",
//     "❤️ Romance",
//     "🛸 Sci-Fi",
//     "📝 Documentary",
//   ];

//   Set<String> selectedGenres = {};

//   void toggleGenre(String genre) {
//     setState(() {
//       if (selectedGenres.contains(genre)) {
//         selectedGenres.remove(genre);
//       } else {
//         selectedGenres.add(genre);
//       }
//     });
//   }


//   @override
//   void initState() {
//     nameController.text=widget.name;
//     emailController.text=widget.email;


//    nameFocusNode.addListener(() => _handleFocusChange("name"));
//     emailFocusNode.addListener(() => _handleFocusChange("email"));
//     passwordFocusNode.addListener(() => _handleFocusChange("password"));
//     super.initState();
//   }


//     void _handleFocusChange(String field) {
//     if (field == "name" && !nameFocusNode.hasFocus) {
//       setState(() => _isEditingName = false);
//     } else if (field == "email" && !emailFocusNode.hasFocus) {
//       setState(() => _isEditingEmail = false);
//     } else if (field == "password" && !passwordFocusNode.hasFocus) {
//       setState(() => _isEditingPassword = false);
//     }
//   }

//   void _enableEditing(String field) {
//     setState(() {
//       if (field == "name") _isEditingName = true;
//       if (field == "email") _isEditingEmail = true;
//       if (field == "password") _isEditingPassword = true;
//     });

//     Future.delayed(Duration(milliseconds: 100), () {
//       if (field == "name") nameFocusNode.requestFocus();
//       if (field == "email") emailFocusNode.requestFocus();
//       if (field == "password") passwordFocusNode.requestFocus();
//     });
//   }



//   @override
//   void dispose() {
//        nameController.dispose();
//     emailController.dispose();
//     passController.dispose();

//     nameFocusNode.dispose();
//     emailFocusNode.dispose();
//     passwordFocusNode.dispose();
//     super.dispose();
//   }


  

//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       heightFactor: 0.8,
//       child: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Spacer(),
//                   Text(
//                     "Edit Profile",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   Spacer(),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                         height: 78,
//                         width: 78,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 15),
//                   InkWell(
//                       onTap: () {
//                         _pickImage();
//                       },
//                       child: _buildButton("Edit Photo", Color(0xffD9D9D9))),
//                   SizedBox(width: 15),
//                   _buildButton("Remove", Color(0xffF4B1B1)),
//                 ],
//               ),
//               Divider(),
//               Text(
//                 "PERSONAL DETAILS",
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//               SizedBox(height: 25),
//          _buildEditableField(
//                 label: "FULL NAME",
//                 field: "name",
//                 controller: nameController,
//                 focusNode: nameFocusNode,
//                 isEditing: _isEditingName,
//               ),
//               _buildEditableField(
//                 label: "EMAIL",
//                 field: "email",
//                 controller: emailController,
//                 focusNode: emailFocusNode,
//                 isEditing: _isEditingEmail,
//               ),
//               _buildEditableField(
//                 label: "PASSWORD",
//                 field: "password",
//                 controller: passController,
//                 focusNode: passwordFocusNode,
//                 isEditing: _isEditingPassword,
//               ),
//               SizedBox(height: 10),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 15.0,
//                 children: genres.map((genre) {
//                   bool isSelected = selectedGenres.contains(genre);
//                   return GestureDetector(
//                     onTap: () => toggleGenre(genre),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.yellow : Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           width: isSelected ? 1 : 1,
//                           color: isSelected
//                               ? Colors.white
//                               : AppColors.Background_Blue,
//                         ),
//                       ),
//                       child: Text(
//                         genre,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomButton(
//                     text: "Update Profile",
//                     color: AppColors.Background_Blue,
//                     txtcolor: AppColors.txtcolor,
//                     onTap: () {},
//                   ),
//                   CustomButton(
//                     text: "Delete Profile",
//                     color: AppColors.warnignRed,
//                     txtcolor: AppColors.txtcolor,
//                     onTap: () {},
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(String text, Color color) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     File? image = await ImagePickerHelper.showImagePicker(context);
//     if (image != null) {
//       setState(() {
//         _selectedImage = image;
//       });
//     }
//   }
  
//   Widget _buildEditableField({
//     required String label,
//     required String field,
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     required bool isEditing,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(label, style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: AppFonts.medium,)),
//               Spacer(),
//               GestureDetector(
//                 onTap: () => _enableEditing(field),
//                 child: Text("Edit",
//                     style: TextStyle(color: Colors.black, fontFamily: AppFonts.medium,fontSize: 12)),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           TextField(
//             controller: controller,
//             focusNode: focusNode,
//             readOnly: !isEditing,
//             decoration: InputDecoration(
//               hintText: "Enter $label",
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey, width: 2.0),
//               ),
//               border: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// File? _selectedImage;
