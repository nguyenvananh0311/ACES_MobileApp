import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/image.dart';
import '../assets/widget_component/languege.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/employee/employee.dart';
import '../services/apiService.dart';
import 'feedback.dart';

class ProfileScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final Function(Locale) onLocaleChange;
  const ProfileScreen(
      {super.key,
      required this.companyId,
      required this.employeeId,
      required this.onLocaleChange});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  late Future<List<dynamic>> futureData;
  bool isLoading = false;
  TimeOfDay timeNow = TimeOfDay.now();
  TimeOfDay endOfMorning = const TimeOfDay(hour: 12, minute: 30);
  int random = Random().nextInt(1000);

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchEmployeeInfo(widget.employeeId, widget.companyId),
    ]);
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.confirm_logout,
          ),
          content: Text(AppLocalizations.of(context)!.logout_confirmation),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('companyId', '');
                await prefs.setInt('employeeId', 0);
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InitialScreen(onLocaleChange: widget.onLocaleChange),
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.yes,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.no,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBarScreen(
        title: localization!.profile,
        actions: Row(
          children: [
            LanguageSelector(onLocaleChange: widget.onLocaleChange),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.white,
              ),
              onSelected: (choice) async {
                switch (choice) {
                  case 'logout':
                    _showLogoutConfirmationDialog(context);
                    break;
                  case 'feedback':
                    // Handle settings logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackScreen(
                          employeeId: widget.employeeId,
                          companyId: widget.companyId,
                        ),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'feedback', 'logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(localization.translate(choice)),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(localization.error(snapshot.error.toString())));
          } else if (snapshot.hasData) {
            final code = snapshot.data![0].statusCode;
            if (code == 500) {
              if (snapshot.data![0].message ==
                  "Value cannot be null. (Parameter 'Cannot find the employee')")
                return const Center(
                    child: Text("Your account has been deleted"));
              return const Center(child: Text('No data available'));
            } else {
              final profile = snapshot.data![0].response;
              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Stack(
                                  children: <Widget>[
                                    ImageUrl(
                                        '${dotenv.env['API_URL'] ?? 'https://203.176.128.5:5678'}/Images/Employees/${widget.employeeId}.png?random=$random',
                                        70),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 1,
                                          minHeight: 1,
                                        ),
                                        child: const Icon(Icons.camera_alt,
                                            color: Colors.grey, size: 20),
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  var fileBase64 = await _pickFile(context);
                                  if (fileBase64 != "") {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var response = await ApiService()
                                        .uploadImage(
                                            Employee(
                                                id: widget.employeeId,
                                                image: fileBase64),
                                            widget.companyId);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (response.isSuccess) {
                                      successToast(localization.upload_success);
                                      setState(() {
                                        random = Random().nextInt(1000);
                                      });
                                    } else {
                                      errorToast(localization.upload_failed);
                                    }
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    profile.branch,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.department),
                              Text(profile.department),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.position),
                              Text(profile.position),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.joinAt),
                              Text(profile.joinTime.substring(0, 10)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(localization.seniority),
                              Text(formatDuration(profile.seniority)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('${localization.appVersion}: 1.0.0'),
                  // ),
                ],
              );
            }
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  String formatDuration(int totalDays) {
    int years = totalDays ~/ 365;
    int remainingDays = totalDays % 365;
    int months = remainingDays ~/ 30;
    int days = remainingDays % 30;
    var localization = AppLocalizations.of(context);
    String? yearString = years <= 1 ? localization?.year : localization?.years;
    String? monthString =
        months <= 1 ? localization?.month : localization?.months;
    String? dayString = days <= 1 ? localization?.day : localization?.days;

    return '$years $yearString $months $monthString $days $dayString';
  }

  Future<String> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final File file = File(result.files.single.path!);
      String base64Image = _convertToBase64(file);
      return base64Image;
    }
    return "";
  }

  String _convertToBase64(File file) {
    File imageFile = File(file.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}

extension LocalizedStrings on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case 'logout':
        return logout;
      case 'feedback':
        return feedback;
      default:
        return key;
    }
  }
}
