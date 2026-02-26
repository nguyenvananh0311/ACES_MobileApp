import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/image.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';

class MemberScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  const MemberScreen(
      {super.key, required this.companyId, required this.employeeId});

  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<MemberScreen> {
  late Future<List<dynamic>> futureData;
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    return await Future.wait([
      ApiService().fetchMembers(widget.employeeId, widget.companyId),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBarScreen(
        title: localization!.member,
        isBack: true,
      ),
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
                  return Center(
                      child:
                          Text(localization.error(snapshot.error.toString())));
                } else if (snapshot.hasData) {
                  final members = snapshot.data![0].response;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: members?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              shadowColor: Colors.black,
                              child: ListTile(
                                leading: ImageUrl(
                                    '${dotenv.env['API_URL'] ?? 'https://203.176.128.5:5678'}/Images/Employees/${members![index].id}.png',
                                    null),
                                title: Text(
                                  members![index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(members![index].position),
                                    Text(members![index].department),
                                    Text(members![index].branch),
                                    Text(members![index].phoneNumber ?? ''),
                                  ],
                                ),
                                trailing: members![index].phoneNumber != null &&
                                        members![index].phoneNumber != ''
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(Icons.phone,
                                            size: 25, color: Colors.white),
                                      )
                                    : const SizedBox(
                                        width: 0,
                                      ),
                                onTap: () {
                                  if (members![index].phoneNumber != null &&
                                      members![index].phoneNumber != "") {
                                    _makePhoneCall(members![index].phoneNumber);
                                  }
                                },
                              ),
                            );
                            // return LeaveItem(
                            //   date: members![index].createdDate == null
                            //       ? ""
                            //       : DateFormat('EEE dd MMMM y').format(leave[index].createdDate as DateTime),
                            //   status: leave[index].status.toString(),
                            //   description: leave[index].reason,
                            //   duration: leave[index].duration,
                            //   onTap: () async {
                            //   },
                            // );
                          },
                        ),
                      ),
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
    );
  }
}
