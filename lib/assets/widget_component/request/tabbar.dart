import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../activities/leaveRequestDetail.dart';
import '../../../activities/overtimeRequestDetail.dart';
import '../../../activities/replaceRequestDetail.dart';
import '../../../l10n/app_localizations.dart';
import '../leaveview/leaveItem.dart';

class TabBarRequestWidget extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final List<dynamic> requests;
  final int currentIndex;
  final Function fetchData;
  final String type;
  const TabBarRequestWidget({super.key, required this.companyId, required this.employeeId, required this.requests, required this.fetchData, required this.currentIndex, required this.type});

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarRequestWidget> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Text(localization!.all, style: const TextStyle(fontSize: 12))),
                Tab(icon: Text(localization.pending, style: const TextStyle(fontSize: 12))),
                Tab(icon: Text(localization.approved, style: const TextStyle(fontSize: 12))),
                Tab(icon: Text(localization.rejected, style: const TextStyle(fontSize: 12))),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabViewScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: widget.requests, fetchData: widget.fetchData,currentIndex: 0, type: widget.type,),
                  TabViewScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: widget.requests, fetchData: widget.fetchData,currentIndex: 1, type: widget.type),
                  TabViewScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: widget.requests, fetchData: widget.fetchData,currentIndex: 2, type: widget.type),
                  TabViewScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: widget.requests, fetchData: widget.fetchData,currentIndex: 3, type: widget.type),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TabViewScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final List<dynamic> requests;
  final int currentIndex;
  final Function fetchData;
  final String type;
  const TabViewScreen({super.key, required this.companyId, required this.employeeId, required this.requests, required this.fetchData, required this.currentIndex, required this.type});

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabViewScreen> {
  late Future<List<dynamic>> futureData;
  late String? _currentStatus;
  var filteredData;

  @override
  void initState() {
    super.initState();
    _handleTabSelection();
  }
  void _handleTabSelection() {
    switch (widget.currentIndex) {
      case 0:
        _currentStatus = null;
        break;
      case 1:
        _currentStatus = 'Pending';
        break;
      case 2:
        _currentStatus = 'Approved';
        break;
      case 3:
        _currentStatus = 'Rejected';
        break;
    }
    filteredData = widget.requests.where((request) {
      if (_currentStatus == null) return true;
      return request.status == _currentStatus;
    }).toList();
  }
  Future<void> _handleRefresh() async {
    widget.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    // TODO: implement build
    return RefreshIndicator(
        onRefresh: _handleRefresh,
        child:  filteredData.isNotEmpty
        ? ListView(
      children: [
        for (int i = 0; i < filteredData.length; i++)
          LeaveItem(
            date: filteredData[i].createdDate == null
                ? ""
                : DateFormat('EEE dd MMMM y HH:mm').format(filteredData[i].createdDate as DateTime),
            status: filteredData[i].status.toString(),
            description: filteredData[i].reason.toString(),
            duration: filteredData[i].duration,
            onTap: () async {
              if(widget.type == "Leave"){
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      GetLeaveRequestScreen(
                        requestId: filteredData[i].id.toString(),
                        companyId: widget.companyId,
                        employeeId: widget.employeeId,
                      )),
                );
                setState(() {
                  _handleRefresh();
                });
              }
              else if(widget.type == "Overtime"){
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      GetOvertimeRequestScreen(
                        requestId: filteredData[i].id.toString(),
                        companyId: widget.companyId,
                        employeeId: widget.employeeId,
                      )),
                );
                setState(() {
                  _handleRefresh();
                });
              }
              else if(widget.type == "Replace"){
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      GetReplaceRequestScreen(
                        requestId: filteredData[i].id.toString(),
                        companyId: widget.companyId,
                        employeeId: widget.employeeId,
                      )),
                );
                setState(() {
                  _handleRefresh();
                });
              }
            },
          ),
      ],
    )
        : Center(child:  Text(localization!.no_data))
    );
  }
}

