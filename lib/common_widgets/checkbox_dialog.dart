import 'package:butterflix/common_widgets/textfield_dialog.dart';
import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CheckboxDialog extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelected;

  const CheckboxDialog({
    Key? key,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  _CheckboxDialogState createState() => _CheckboxDialogState();
}

class _CheckboxDialogState extends State<CheckboxDialog> {
  List<String> playlists = []; 
  List<bool> selected = [];

  @override
  void initState() {
    super.initState();
    playlists = List.from(widget.options);
    selected = List.generate(playlists.length, (index) => false);
  }

  void _addNewPlaylist(String playlistName) {
    if (playlistName.isNotEmpty) {
      setState(() {
        playlists.add(playlistName); 
        selected.add(false); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add To Playlist",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.semibold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(playlists.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Checkbox(
                            value: selected[index],
                            onChanged: (bool? value) {
                              setState(() {
                                selected[index] = value!;
                              });
                            },
                            visualDensity: VisualDensity.compact,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              playlists[index],
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TextFieldDialog(
                      onSubmitted: (String text) {
                        _addNewPlaylist(text); 
                        
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.Button_Yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Add To Playlist",
                          style: TextStyle(
                            fontFamily: AppFonts.medium,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
