import 'package:butterflix/common_widgets/custom_buttons.dart';
import 'package:butterflix/user_profile/profile_screen.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RequestMovieScreen extends StatefulWidget {
  const RequestMovieScreen({super.key});

  @override
  State<RequestMovieScreen> createState() => _RequestMovieScreenState();
}

class _RequestMovieScreenState extends State<RequestMovieScreen> {
  TextEditingController movieNameController = TextEditingController();
  TextEditingController movieDateController = TextEditingController();
  bool _showConfirmationContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  surfaceTintColor: Colors.transparent, 
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
        ),
        title: Text(
          "Request a Movie or Show",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter a movie name or web series you want us to add on Butterflix. We are happy to add your choice on this platform.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 40),
            Text("Name", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 5),
            TextField(
              controller: movieNameController,
              decoration: InputDecoration(
                hintText: "e.g., The Avengers End Game",
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Color(0xffC4C4C4): AppColors.divider_color, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? AppColors.Background_Blue : AppColors.Button_Yellow, width: 1.5),
                    ),
              ),
            ),
            SizedBox(height: 20),
            Text("Release date", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 5),
            TextField(
              controller: movieDateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "e.g., 12/07/2019",
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 7),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Color(0xffC4C4C4): AppColors.divider_color, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? AppColors.Background_Blue : AppColors.Button_Yellow, width: 1.5),
                    ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  movieDateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              },
            ),
            SizedBox(height: 20),
            Text("Upload Poster (optional)", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 5),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                hintText: "Movie poster",
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? Color(0xffC4C4C4): AppColors.divider_color, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.light ? AppColors.Background_Blue : AppColors.Button_Yellow, width: 1.5),
                    ),
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
              color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : AppColors.Button_Yellow,
              txtcolor: Theme.of(context).brightness == Brightness.light ? Colors.white:Colors.black,
              text: "Confirm Request",
              fontsize: 18,
              fullWidth: true,
              onTap: () {
                setState(() {
                  FToast fToast = FToast();
                  fToast.init(context);
                  fToast.showToast(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Your request has been sent. You’ll be redirected to the profile page.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 3),
                  );
                });
                Future.delayed(const Duration(seconds: 5), () {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
