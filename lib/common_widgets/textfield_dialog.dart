import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldDialog extends StatefulWidget {
  final Function(String) onSubmitted;

  const TextFieldDialog({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  _TextFieldDialogState createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create New Playlist",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.semibold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                hintText: "Enter Playlist Title..",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xffBCBCBC), width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      widget.onSubmitted(_controller.text.trim()); 
                      Navigator.pop(context); 
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow, 
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Center(
                      child: Text(
                        "Create",
                        style: TextStyle(
                          fontFamily: AppFonts.medium,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context); 
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF9D7D7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily:AppFonts.medium,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
