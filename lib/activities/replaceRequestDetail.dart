
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../assets/widget_component/addLeaveRequestView/leaveTypeSelector.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/leaveview/leaveDetailItem.dart';
import '../assets/widget_component/toast.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';


class GetReplaceRequestScreen extends StatefulWidget {
  final String requestId;
  final String companyId;
  final int employeeId;
  const GetReplaceRequestScreen({super.key, required this.companyId, required this.employeeId, required this.requestId,});
  @override
  _GetReplaceRequestState createState() => _GetReplaceRequestState();
}


class _GetReplaceRequestState extends State<GetReplaceRequestScreen> {
  String companyId = "0690f1a8-ad36-4b69-b042-d44c2d7fba92";
  int employeeId = 51;
  late Future<List<dynamic>> futureData;

  String typeErrorLog = "";
  DateTime now = DateTime.now();
  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchReplaceRequest(widget.requestId, companyId) // example employee ID
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
        appBar: CustomAppBarScreen(title: localization!.replaceRequestDetail, isBack: true,),
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
              return Center(child: Text(localization.error(snapshot.error.toString())));
            } else if (snapshot.hasData) {
              final replaceRequest = snapshot.data![0].response;
              if(replaceRequest == null)
                {
                  return Center(child: Text(localization.no_data));
                }
              return SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20,5,20,20),
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
                        LeaveTypeSelector(
                            selectedLeaveType: replaceRequest!.isFromMorning ? "Morning" : "Afternoon",
                            onChanged: (String? newValue) {
                            },
                            title: localization.from),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(DateFormat('EEE dd MMMM y').format(replaceRequest.fromDate), style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LeaveTypeSelector(
                            selectedLeaveType: replaceRequest.isToAfternoon ? "Afternoon" : "Morning",
                            onChanged: (String? newValue) {
                            },
                            title: localization.to),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(DateFormat('EEE dd MMMM y').format(replaceRequest.toDate) , style: const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LeaveDetailItem(label: localization.total,description:  "${replaceRequest.duration} ${localization.days}"),
                        LeaveDetailItem(label: localization.phoneNumber,description:  replaceRequest.contactNumber),
                        Row(
                          children: <Widget>[
                            Text(localization.status, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(replaceRequest.status.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: replaceRequest.status == "Approved"? Colors.green : replaceRequest.status == "Rejected" ? Colors.red : Colors.orange),),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if(replaceRequest.updateByName != null)
                        LeaveDetailItem(label: localization.approvedBy,description:  replaceRequest.updateByName.toString()),
                        LeaveDetailItem(label: localization.comment,description:  replaceRequest.comment != null ? replaceRequest.comment.toString() : ''),
                        LeaveDetailItem(label: localization.reason,description:  replaceRequest.reason.toString() ),
                        if(replaceRequest.fileName != null && replaceRequest.fileName != '')
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: 'http://116.212.136.14:5678/Images/Requests/${replaceRequest.fileName}',
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const SizedBox(height: 10,),
                          ),
                        ),
                        const SizedBox(height: 16,),
                        if(replaceRequest.status == "Pending")
                        Center(
                          child: ElevatedButton(
                            onPressed: () async  {
                              var response = await ApiService().cancelReplaceRequest(widget.requestId, companyId);
                              if (response.isSuccess) {
                                successToast(localization.canceledSuccessfully);
                                Navigator.pop(context);
                              } else {
                                errorToast(localization.failedToCancel);
                              }
                            },
                            child: Text(localization.cancel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              ;
            } else {
              return Center(child: Text(localization.no_data));
            }
          },
        )
    );
  }

}

