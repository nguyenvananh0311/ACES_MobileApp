import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class RatingScreen extends StatefulWidget {
  final Function(int) onTab;
  RatingScreen({super.key, required this.onTab});
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int selectedRating = 2; // Mặc định chọn giá trị trung lập (index 2)

  // Danh sách các biểu tượng và mô tả
  final List<Map<String, dynamic>> ratings = [
    {'emoji': '😡', 'label': 'Angry'},
    {'emoji': '🙁', 'label': 'Sad'},
    {'emoji': '😐', 'label': 'Neutral'},
    {'emoji': '😊', 'label': 'Good'},
    {'emoji': '😍', 'label': 'Loved'},
  ];

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization!.rate_experience,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(ratings.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRating = index;
                  });
                  widget.onTab(index);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedRating == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        ratings[index]['emoji'],
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Hiển thị mô tả
                    Text(
                      ratings[index]['label'],
                      style: TextStyle(
                        color: selectedRating == index
                            ? Colors.blue
                            : Colors.black,
                        fontWeight: selectedRating == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
