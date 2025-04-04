// import 'package:flutter/material.dart';

// class DynamicDropdown extends StatefulWidget {
//   final List<String> items;
//   final String initialValue;
//   final Function(String) onChanged;

//   const DynamicDropdown({
//     Key? key,
//     required this.items,
//     required this.initialValue,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   _DynamicDropdownState createState() => _DynamicDropdownState();
// }

// class _DynamicDropdownState extends State<DynamicDropdown> {
//   String? selectedValue;
//   late List<String> dropdownItems;

//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue;
//     dropdownItems = [widget.initialValue, ...widget.items.toSet().toList()];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return IntrinsicWidth( // Dynamically adjusts width based on selected item
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: FittedBox( // Ensures it does not overflow
//               fit: BoxFit.scaleDown,
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: selectedValue,
//                   isDense: true,
//                   items: dropdownItems.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: const TextStyle(fontSize: 16),
//                         overflow: TextOverflow.ellipsis, // Prevents text overflow
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         selectedValue = newValue;
//                       });
//                       widget.onChanged(newValue);
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
