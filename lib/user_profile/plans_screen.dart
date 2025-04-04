import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TabBar(
          Container(
            decoration: BoxDecoration(
              color:
                  Colors.transparent, // No background for the tab bar container
            ),
            child: TabBar(
              dividerColor: Colors.transparent, // Remove bottom border
              indicator: BoxDecoration(
                color: Colors.transparent, // No default selection background
              ),
              labelColor: Colors.black, // Text color for selected tab
              unselectedLabelColor:
                  Colors.black, // Text color for unselected tab
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.Button_Yellow,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Text(
                      "Gold Plan",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Text(
                      "Premium",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            // Adjust height as needed for the plan content area
            height: 500,
            child: TabBarView(
              children: [
                // Gold plan content
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 40, right: 20, top: 20),
                      color: const Color(0xFFF3F3F0),
                      child: Container(
                        width: 380,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Price header
                            Container(
                              width: double.infinity,
                              height: 75,
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xEB161616), // rgba(22,22,22,0.92)
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: const Color(0xFFE5CC03),
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '\$9.99 USD',
                                    style: TextStyle(
                                      color: Color(0xFFE5CC03),
                                      fontSize: 30,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    '/ MO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: 'Poppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            // Features container
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F0),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: const Color(0xFFE5CC03),
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Feature items
                                  _buildFeatureItem(
                                    'Free Installation With Remote Assistance On Your\n4K (Ultra HD) Amazon Fire TV With Alexa App',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    '24-Hour Technical Support To Assist You At\nAny Time',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    'Right To Request Additional Exclusive Content\nPer Month',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    'Enjoy Butterflix On All Your Devices At The\nSame Time And Without Ads',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    'New Movies And Series Every Week',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    'Early Access To New Releases And Special\nContent Before Other Users',
                                  ),
                                  const SizedBox(height: 22),
                                  _buildFeatureItem(
                                    'HD Surround Sound For A Home Theater\nExperience',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.Button_Yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: const Text(
                                "Gold Plan",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Silver plan content
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xff1E1E1E),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "Silver Plan Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Non-toggleable checkbox
        SizedBox(
          width: 15,
          height: 15,
          child: Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: Checkbox(
              value: true,
              onChanged: null, // Null makes it non-interactive
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => const Color(0xFF004AAD),
              ),
              checkColor: const Color(0xFFE5CC03),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ),

        const SizedBox(width: 18),

        // Feature text
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              height: 1.5, // Approximates the 15px line height
            ),
          ),
        ),
      ],
    );
  }
}
