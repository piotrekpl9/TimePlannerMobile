import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';

class MainScaffold extends StatelessWidget {
  final Widget? bottomNavigationBar;
  final Widget body;
  final PreferredSizeWidget? appBar;
  const MainScaffold(
      {super.key, required this.body, this.bottomNavigationBar, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background2.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: appBar,
        backgroundColor: const Color.fromARGB(37, 0, 0, 0),
        extendBody: true,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: false,
        body: body,
      ),
    );
  }
}
