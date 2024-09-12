
import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/request/tabbar.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';
import 'addOTRequest.dart';


class OvertimeScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const OvertimeScreen({super.key, required this.companyId, required this.employeeId});

  @override
  _OvertimeState createState() => _OvertimeState();
}

class _OvertimeState extends State<OvertimeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<dynamic>> futureData;
  String? _currentStatus;
  var _overtime;
  var filteredOTData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    futureData = fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchOT(widget.employeeId,widget.companyId, _currentStatus),
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
      appBar: CustomAppBarScreen(title: localization!.overtimeTitle, isBack: true,),
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
            return Center(child: Text(localization.error(snapshot.error.toString())));
          } else if (snapshot.hasData) {
            _overtime = snapshot.data![0].response;

            return Column(
              children: [
                TabBarRequestWidget(companyId: widget.companyId, employeeId: widget.employeeId, requests: _overtime,
                    fetchData: _handleRefresh,currentIndex: 0, type: "Overtime")
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
            MaterialPageRoute(builder: (context) => AddOvertimeRequestScreen(companyId: widget.companyId, employeeId: widget.employeeId, requests: _overtime,)),
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



