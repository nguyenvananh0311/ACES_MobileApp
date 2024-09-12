import 'package:ems/assets/widget_component/feedback/rating.dart';
import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/feedback/feedback.dart' as feedbackModel;
import '../services/apiService.dart';

class FeedbackScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const FeedbackScreen({super.key, required this.companyId, required this.employeeId});

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackScreen> {
  late Future<List<dynamic>> futureData;
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController recommendationController = TextEditingController();
  late bool isLoading = false;
  int selectedRating = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    recommendationController.dispose();
    super.dispose();
  }
  void _handleRatingChanged(int rating) {
    setState(() {
      selectedRating = rating; // Cập nhật rating đã chọn
    });
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Ẩn bàn phím
      },
      child: Scaffold(
        appBar: CustomAppBarScreen(title: localization!.feedback, isBack: true),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.give_feedback,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 10),
                RatingScreen(
                  onTab: _handleRatingChanged,
                ),
                const SizedBox(height: 20),
                Text(
                  "${localization.feedback}(*):",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 10),
                // Bọc TextField trong Expanded để nó có thể giãn ra hợp lý
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: feedbackController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: localization.write_feedback,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Text(
                  localization.recommendation,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: recommendationController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: localization.write_recommendation,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      if (feedbackController.text.isEmpty) {
                        errorToast(localization.errorLeaveRequest);
                        return;
                      }

                      feedbackModel.Feedback request = feedbackModel.Feedback(
                        employeeId: widget.employeeId,
                        companyId: widget.companyId,
                        feedback: feedbackController.text,
                        recommendation: recommendationController.text,
                        rating: selectedRating, // Thay đổi giá trị rating tùy theo RatingScreen
                      );

                      setState(() {
                        isLoading = true;
                      });

                      var response = await ApiService().addFeedback(request, widget.companyId);

                      setState(() {
                        isLoading = false;
                      });

                      if (response.isSuccess) {
                        successToast(localization.submitSuccess);
                        Navigator.pop(context);
                      } else {
                        errorToast(localization.submitFailure);
                      }
                    },
                    child: Text(
                      localization.submit,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
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
