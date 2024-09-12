import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TabBarWidget extends StatefulWidget {
  final TabController tabController;

  const TabBarWidget({super.key, required this.tabController});

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return TabBar(
        controller: widget.tabController,
        // isScrollable: true,
        tabs:  [
          Tab(icon: Text(localization!.all, style: const TextStyle(fontSize: 12))),
          Tab(icon: Text(localization.pending, style: const TextStyle(fontSize: 12))),
          Tab(icon: Text(localization.approved, style: const TextStyle(fontSize: 12))),
          Tab(icon: Text(localization.rejected, style: const TextStyle(fontSize: 12))),
        ],
        labelColor: Colors.black,
        dividerColor: Colors.grey,
    );
  }
}
