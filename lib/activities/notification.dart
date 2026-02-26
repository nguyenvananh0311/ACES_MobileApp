import 'package:ems/activities/replaceRequestDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../assets/widget_component/appBar/otherAppBar.dart';
import '../assets/widget_component/image.dart';
import '../assets/widget_component/languege.dart';
import '../l10n/app_localizations.dart';
import '../services/apiService.dart';
import '../services/signalR/signalrServiceProvider.dart';
import 'leaveRequestDetail.dart';
import 'overtimeRequestDetail.dart';

class NotificationScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final Function(Locale) onLocaleChange;

  const NotificationScreen({
    super.key,
    required this.companyId,
    required this.employeeId,
    required this.onLocaleChange,
  });
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationScreen> {
  late Future<List<dynamic>> futureData;
  final ScrollController _scrollController = ScrollController();
  bool maskAsRead = false;
  bool isLoading = false;
  int pageIndex = 0;
  int pageSize = 10;
  int total = 0;
  List<dynamic> notifications = [];
  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        pageIndex++;
        if (pageIndex < (total / pageSize)) {
          fetchData(page: pageIndex);
        }
      }
    });
  }

  void fetchData({int page = 0}) async {
    isLoading = true;
    var res = await Future.wait([
      ApiService()
          .fetchAllNotification(widget.employeeId, widget.companyId, page),
    ]);
    setState(() {
      isLoading = false;
      total = res[0].total;
      if (pageIndex == 0) notifications.clear();
      notifications.addAll(res[0].response as Iterable);
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      notifications.clear();
      pageIndex = 0;
      fetchData(page: pageIndex);
    });
    final signalRServiceProvider =
        Provider.of<SignalRServiceProvider>(context, listen: false);
    signalRServiceProvider.reload(widget.employeeId, widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          // backgroundColor: Colors.blue,
          appBar: CustomAppBarScreen(
            title: localization!.notification,
            actions: LanguageSelector(onLocaleChange: widget.onLocaleChange),
          ),
          body: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: isLoading
                      ? const Stack(
                          children: [
                            Positioned.fill(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        )
                      : notifications.isNotEmpty
                          ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(localization.markAllAsRead),
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch.adaptive(
                                        value: maskAsRead,
                                        onChanged: (bool value) {
                                          setState(() {
                                            maskAsRead = value;
                                            for (int i = 0;
                                                i < notifications.length;
                                                i++) {
                                              notifications[i]!.setIsRead =
                                                  true;
                                            }
                                          });
                                          ApiService().updateAllNotification(
                                              widget.employeeId,
                                              widget.companyId);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  itemCount: notifications.length +
                                      (isLoading ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    final notification = notifications[index];
                                    return Card(
                                      child: ListTile(
                                        leading: ImageUrl(
                                            'https://203.176.128.5:5678/Images/Employees/${notification.notification.createdById}.png',
                                            null),
                                        title: Text(
                                          notification.notification.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notification
                                                  .notification.description,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              DateFormat('EEE dd MMMM y')
                                                  .format(notification
                                                      .notification
                                                      .createdTime),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(
                                          Icons.circle,
                                          color: notification.isRead
                                              ? Colors.green
                                              : Colors.red,
                                          size: 15,
                                        ),
                                        onTap: () async {
                                          if (!notification.isRead) {
                                            ApiService().updateNotification(
                                                widget.employeeId,
                                                notification.notification.id,
                                                widget.companyId);
                                          }
                                          switch (
                                              notification.notification.event) {
                                            case "Replacement":
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetReplaceRequestScreen(
                                                    companyId: widget.companyId,
                                                    employeeId:
                                                        widget.employeeId,
                                                    requestId: notification
                                                        .notification.link,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case "Overtime":
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetOvertimeRequestScreen(
                                                    companyId: widget.companyId,
                                                    employeeId:
                                                        widget.employeeId,
                                                    requestId: notification
                                                        .notification.link,
                                                  ),
                                                ),
                                              );
                                              break;
                                            case "Leave":
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetLeaveRequestScreen(
                                                    companyId: widget.companyId,
                                                    employeeId:
                                                        widget.employeeId,
                                                    requestId: notification
                                                        .notification.link,
                                                  ),
                                                ),
                                              );
                                              break;
                                          }
                                          setState(() {
                                            fetchData();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ))
                              ],
                            )
                          : Center(child: Text(localization.no_data))))),
    );
  }
}
