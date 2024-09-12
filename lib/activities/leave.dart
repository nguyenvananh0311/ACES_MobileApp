import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/leaveview/circularPercentIndicator.dart';
import '../assets/widget_component/request/tabbar.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';
import 'addLeaveRequest.dart';

class LeaveScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const LeaveScreen({super.key, required this.companyId, required this.employeeId});

  @override
  _LeaveState createState() => _LeaveState();
}
class _LeaveState extends State<LeaveScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<dynamic>> futureData;
  String? _currentStatus;
  var _leaveData;
  var _monthlyLeaveData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    futureData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchLeave(widget.employeeId, widget.companyId, _currentStatus),
      ApiService().fetchMonthlyLeave(widget.employeeId, widget.companyId),
    ]);
  }
  Future<void> _handleRefresh() async {
    setState(() {
      futureData = fetchData();
    });
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBarScreen(title: localization!.leave, isBack: true,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
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
                  return Center(child: Text(localization.error(snapshot.error.toString())));
                } else if (snapshot.hasData) {
                  _leaveData = snapshot.data![0].response;
                  _monthlyLeaveData = snapshot.data![1].response;

                  return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 6.0,
                                  percent: _monthlyLeaveData == null ? 0 : _monthlyLeaveData.usedAnnualDay / _monthlyLeaveData.earnedAnnualDay,
                                  center: Text("${_monthlyLeaveData!.usedAnnualDay}"),
                                  progressColor: Colors.blue,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${localization.annual_leave}: ${_monthlyLeaveData.usedAnnualDay} / ${_monthlyLeaveData.earnedAnnualDay}"),
                                    Text("${localization.replace_leave}: ${_monthlyLeaveData.usedReplaceDay} / ${_monthlyLeaveData.earnedReplaceDay}"),
                                    Text("${localization.unpaid}: ${_monthlyLeaveData.unpaid}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TabBarRequestWidget(companyId: widget.companyId, employeeId: widget.employeeId, requests: _leaveData,
                              fetchData: _handleRefresh,currentIndex: 0, type: "Leave")
                        ],
                      );
                } else {
                  return Center(child: Text(localization.no_data));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddLeaveRequestScreen(
                companyId: widget.companyId,
                employeeId: widget.employeeId,
                requests: _leaveData,
              ),
            ),
          );
          setState(() {
            futureData = fetchData();
          }); // Cập nhật dữ liệu khi quay lại
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

