import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../assets/widget_component/addLeaveRequestView/leaveTypeSelector.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/leaveview/leaveDetailItem.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';

class GetLeaveRequestScreen extends StatefulWidget {
  final String requestId;
  final String companyId;
  final int employeeId;
  const GetLeaveRequestScreen(
      {super.key,
      required this.companyId,
      required this.employeeId,
      required this.requestId});
  @override
  _GetLeaveRequestState createState() => _GetLeaveRequestState();
}

class _GetLeaveRequestState extends State<GetLeaveRequestScreen> {
  String companyId = "0690f1a8-ad36-4b69-b042-d44c2d7fba92";
  int employeeId = 51;
  late Future<List<dynamic>> futureData;

  String typeErrorLog = "";
  DateTime now = DateTime.now();
  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService()
          .fetchLeaveRequest(widget.requestId, companyId) // example employee ID
    ]);
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
        appBar: CustomAppBarScreen(
          title: localization!.leaveRequestDetail,
          isBack: true,
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
              final leaveRequest = snapshot.data![0].response;

              return SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        LeaveTypeSelector(
                            selectedLeaveType: leaveRequest!.isFromMorning
                                ? "Morning"
                                : "Afternoon",
                            onChanged: (String? newValue) {},
                            title: localization.from),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEE dd MMMM y')
                                  .format(leaveRequest.fromDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LeaveTypeSelector(
                            selectedLeaveType: leaveRequest.isToAfternoon
                                ? "Afternoon"
                                : "Morning",
                            onChanged: (String? newValue) {},
                            title: localization.to),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('EEE dd MMMM y')
                                  .format(leaveRequest.toDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LeaveDetailItem(
                            label: localization.total,
                            description:
                                "${leaveRequest.duration} ${localization.days}"),
                        LeaveDetailItem(
                            label: localization.leaveType,
                            description: leaveRequest.type),
                        LeaveDetailItem(
                            label: localization.phoneNumber,
                            description: leaveRequest.contactNumber),
                        Row(
                          children: <Widget>[
                            Text("${localization.status}:",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                              leaveRequest.status.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: leaveRequest.status == "Approved"
                                      ? Colors.green
                                      : leaveRequest.status == "Rejected"
                                          ? Colors.red
                                          : Colors.orange),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (leaveRequest.updateByName != null)
                          LeaveDetailItem(
                              label: localization.approvedBy,
                              description:
                                  leaveRequest.updateByName.toString()),
                        LeaveDetailItem(
                            label: localization.comment,
                            description: leaveRequest.comment != null
                                ? leaveRequest.comment.toString()
                                : ''),
                        LeaveDetailItem(
                            label: localization.reason,
                            description: leaveRequest.reason),
                        if (leaveRequest.fileName != null &&
                            leaveRequest.fileName != '')
                          Center(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://203.176.128.5:5678/Images/Requests/${leaveRequest.fileName}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const SizedBox(
                                height: 10,
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (leaveRequest.status == "Pending")
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                var response = await ApiService()
                                    .cancelLeaveRequest(
                                        widget.requestId, companyId);
                                if (response.isSuccess) {
                                  Fluttertoast.showToast(
                                    msg: "Leave request canceled successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Failed to cancel leave request",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  print(
                                      'Failed to add leave request: ${response.message}');
                                }
                                // Navigator.pop(context,'success');
                              },
                              child: Text(localization.cancel),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ));
  }
}
