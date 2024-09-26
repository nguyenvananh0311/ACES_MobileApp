
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ems/activities/scanQRcode.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/attendanceView/attendanceReason.dart';
import '../assets/widget_component/leaveview/leaveDetailItem.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../models/attendance/branch.dart';
import '../models/overtime/overtimeRequest.dart';
import '../services/apiService.dart';
import '../services/location.dart';


class GetOvertimeRequestScreen extends StatefulWidget {
  final String requestId;
  final String companyId;
  final int employeeId;
  const GetOvertimeRequestScreen({super.key, required this.companyId, required this.employeeId, required this.requestId,});
  @override
  _GetOvertimeRequestState createState() => _GetOvertimeRequestState();
}


class _GetOvertimeRequestState extends State<GetOvertimeRequestScreen> {
  String companyId = "0690f1a8-ad36-4b69-b042-d44c2d7fba92";
  int employeeId = 51;
  late Future<List<dynamic>> futureData;
  bool isLoading = false;

  String typeErrorLog = "";
  DateTime now = DateTime.now();
  Future<bool> _checkLocationAndShowDialog(Branch branch) async {
    setState(() {
      isLoading = true;
    });
    bool isCorrectLocation = await checkLocation(branch.latitude, branch.longitude, branch.distance);
    setState(() {
      isLoading = false;
    });
    if (isCorrectLocation) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanQRScreen(employeeId: widget.employeeId, companyId: widget.companyId, requestId: widget.requestId, branch: branch.name,)),
      );
      setState(() {
        futureData = fetchData();
      });
    }

    // else {
    //   showErrorDialog(context);
    // }
    return isCorrectLocation;
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchOTRequest(widget.requestId, companyId) // example employee ID
    ]);
  }
  @override
  void initState() {
    super.initState();
    futureData = fetchData(); // example employee ID
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);

    return Scaffold(
        appBar: CustomAppBarScreen(title: localization!.overtimeRequestDetail, isBack: true,),
        body: FutureBuilder<List<dynamic>>(
          future: futureData,
          builder: (context, snapshot){
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
              final otRequest = snapshot.data![0].response;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    if(isLoading)
                        const Center(child: CircularProgressIndicator()),
                    // if(otRequest.status == "Approved")
                    //   Padding(
                    //     padding: const EdgeInsets.fromLTRB(20,5,20,5),
                    //     child: Text("Note: ${localization.ot_checkin_note}", style: TextStyle(color: Colors.red),),
                    //   ),
                    // if(otRequest.status == "Approved")
                    //   ElevatedButton(
                    //     onPressed: () async {
                    //       if(checkTime(now, otRequest)){ //&& (otRequest.checkInTime == null || otRequest.checkOutTime == null) ){
                    //         var response = await ApiService().fetchBranch(widget.employeeId, widget.companyId);
                    //         if (response.isSuccess) {
                    //           List<Branch>? branches = response.response;
                    //           bool isCorrectBranch = false;
                    //           for(int i =0; i< branches!.length; i++){
                    //             bool result = await _checkLocationAndShowDialog(branches[i]);
                    //             if(result){
                    //               isCorrectBranch = true;
                    //               break;
                    //             }
                    //           }
                    //           if(!isCorrectBranch){
                    //             showErrorDialog(context);
                    //           }
                    //         }
                    //         else {
                    //           errorToast(localization.cannot_check_in);
                    //         }
                    //       }
                    //       // else if(otRequest.checkInTime != null && otRequest.checkOutTime != null){
                    //       //   errorToast(localization.alreadyCheckedOut);
                    //       // }
                    //       else{
                    //         errorToast(localization.checkinTimeOutsideOvertime);
                    //       }
                    //     },
                    //     style: checkTime(now, otRequest) && (otRequest.checkInTime == null || otRequest.checkOutTime == null) ? ElevatedButton.styleFrom(
                    //       foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: const CircleBorder(),
                    //       padding: const EdgeInsets.all(40), // <-- Splash color
                    //     ) : ElevatedButton.styleFrom(
                    //       foregroundColor: Colors.white, backgroundColor: Colors.grey, shape: const CircleBorder(),
                    //       padding: const EdgeInsets.all(40), // <-- Splash color
                    //     ),
                    //     child: Text("${otRequest.checkInTime == null ? localization.check_in : localization.check_out} \n$formattedTime",
                    //       style: const TextStyle(fontSize: 16), textAlign: TextAlign.center,)
                    // ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(20,10,20,20),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      shadowColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                             Text(
                              "${localization.from}:", textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(DateFormat('EEE dd MMMM y HH:mm').format(otRequest!.fromDate), style: const TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(height: 16),
                             Text(
                               "${localization.to}:", textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.bold),
                            ) ,
                            Row(
                              children: <Widget>[
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 8),
                                Text(DateFormat('EEE dd MMMM y HH:mm').format(otRequest.toDate) , style: const TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(height: 16),
                            LeaveDetailItem(label: "Total",description:  "${otRequest.duration} hour(s)"),
                            LeaveDetailItem(label: "Phone number",description:  otRequest.contactNumber),
                            Row(
                              children: <Widget>[
                                Text(localization.status, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const Spacer(),
                                Text(otRequest.status.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: otRequest.status == "Approved"? Colors.green : otRequest.status == "Rejected" ? Colors.red : Colors.orange),),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if(otRequest.updateByName != null)
                              LeaveDetailItem(label: localization.approvedBy,description:  otRequest.updateByName.toString()),
                            LeaveDetailItem(label: localization.comment,description:  otRequest.comment != null ? otRequest.comment.toString() : ''),
                            LeaveDetailItem(label: localization.reason,description:  otRequest.reason.toString() ),
                            LeaveDetailItem(label: localization.check_in,description: otRequest.checkInTime == null ? '' : DateFormat('dd MMMM y hh:mm').format(otRequest.checkInTime) ),
                            LeaveDetailItem(label: localization.check_out,description: otRequest.checkOutTime == null ? '' : DateFormat('dd MMMM y hh:mm').format(otRequest.checkOutTime) ),
                            if(otRequest.fileName != null && otRequest.fileName != '')
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: 'http://116.212.136.14:5678/Images/Requests/${otRequest.fileName}',
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const SizedBox(height: 10,),
                                ),
                              ),
                            const SizedBox(height: 16,),
                            if(otRequest.status == "Pending")
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async  {
                                    var response = await ApiService().cancelOvertimeRequest(widget.requestId, companyId);
                                    if (response.isSuccess) {
                                      successToast(localization.canceledSuccessfully);
                                      Navigator.pop(context);
                                    } else {
                                      errorToast(localization.failedToCancel);
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
                  ],
                )
              )
              ;
            } else {
              return Center(child: Text(localization.no_data));
            }
          },
        )
    );
  }
  bool checkTime(DateTime time, OvertimeRequest otRequest){
    if(otRequest.fromDate.add(const Duration(minutes: -30)).isBefore(time) && time.isBefore(otRequest.toDate.add(const Duration(hours: 1)))) {
      return true;
    }
    return false;
  }

}

