import 'package:flutter/material.dart';
import '../assets/widget_component/appBar/homeAppBar.dart';
import '../assets/widget_component/languege.dart';
import '../l10n/app_localizations.dart';
import 'attendance.dart';
import 'members.dart';
import 'overtime.dart';
import 'workingDay.dart';
import 'replace.dart';
import 'leave.dart';
import '../assets/widget_component/homeview/optiontile.dart';

class HomeScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final String? employeeName;
  final Function(Locale) onLocaleChange;

  const HomeScreen({
    super.key,
    required this.companyId,
    required this.employeeId,
    required this.onLocaleChange,
    this.employeeName
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () async => false, // Ngăn chặn việc quay lại
      child: Scaffold(
        appBar: HomeAppBarScreen(name: widget.employeeName, title: localization!.title, iconButton: LanguageSelector (onLocaleChange: widget.onLocaleChange),),
        // AppBar(
        //   backgroundColor: Colors.blue,
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(localization!.title),
        //
        //     ],
        //   ),
        //   actions: [
        //     LanguageSelector (onLocaleChange: widget.onLocaleChange),
        //     const SizedBox(width: 10,),
        //   ],
        // ),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Text(signalRServiceProvider.message),
                const SizedBox(height: 20),
                OptionTile(
                  icon: Icons.calendar_today,
                  title: localization.attendanceTitle,
                  subtitle: localization.attendanceSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceScreen(companyId: widget.companyId, employeeId: widget.employeeId,),
                      ),
                    );
                  },
                ),
                OptionTile(
                  icon: Icons.work_history,
                  title: localization.leaveTitle,
                  subtitle: localization.leaveSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.green,
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaveScreen(companyId: widget.companyId, employeeId: widget.employeeId,),
                      ),
                    );
                  },
                ),
                OptionTile(
                  icon: Icons.cached,
                  title: localization.replaceTitle,
                  subtitle: localization.replaceSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.cyan,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplaceScreen(companyId: widget.companyId, employeeId: widget.employeeId, ),
                      ),
                    );
                  },
                ),
                OptionTile(
                  icon: Icons.timer,
                  title: localization.overtimeTitle,
                  subtitle: localization.overtimeSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.deepPurpleAccent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OvertimeScreen(companyId: widget.companyId, employeeId: widget.employeeId,),
                      ),
                    );
                  },
                ),
                OptionTile(
                  icon: Icons.calendar_view_month,
                  title: localization.calendarTitle,
                  subtitle: localization.calendarSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkingdayScreen(companyId: widget.companyId, employeeId: widget.employeeId, ),
                      ),
                    );
                  },
                ),
                OptionTile(
                  icon: Icons.group,
                  title: localization.membersTitle,
                  subtitle: localization.membersSubtitle,
                  iconColor: Colors.white,
                  iconBackgroundColor: Colors.pink,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberScreen(companyId: widget.companyId, employeeId: widget.employeeId,),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}
