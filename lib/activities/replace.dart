
import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/leaveview/circularPercentIndicator.dart';
import '../assets/widget_component/request/tabbar.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';
import 'addReplaceRequest.dart';


class ReplaceScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const ReplaceScreen({super.key, required this.companyId, required this.employeeId,});

  @override
  _ReplaceState createState() => _ReplaceState();
}
class _ReplaceState extends State<ReplaceScreen> with SingleTickerProviderStateMixin {
  late Future<List<dynamic>> futureData;
  String? _currentStatus;
  var _replace;
  var _monthlyLeave;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchReplace(widget.employeeId,widget.companyId, _currentStatus),
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
      appBar: CustomAppBarScreen(title: localization!.replace, isBack: true,),
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
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            _replace = snapshot.data![0].response;
            _monthlyLeave = snapshot.data![1].response;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,5,16,16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 6.0,
                        percent: _monthlyLeave!.usedReplaceDay == 0 ? 0 : _monthlyLeave.usedReplaceDay/_monthlyLeave.earnedReplaceDay,
                        center: Text("${_monthlyLeave.usedReplaceDay}"),
                        progressColor: Colors.blue,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${localization.replace_leave}: ${_monthlyLeave.usedReplaceDay ?? 0} / ${_monthlyLeave.earnedReplaceDay ?? 1.5}"),
                        ],
                      ),
                    ],
                  ),
                ),
                TabBarRequestWidget(companyId: widget.companyId, employeeId: widget.employeeId, requests: _replace,
                    fetchData: _handleRefresh,currentIndex: 0, type: "Replace")
              ],
            );
          } else {
            return Center(child: Text(localization.no_data));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReplaceRequestScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: _replace,)),
          );
          setState(() {
            futureData = fetchData();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


