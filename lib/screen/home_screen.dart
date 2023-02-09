import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer:
    Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 7) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5, 6, 7, 8]
            .map((e) => Image.asset(
                  'assets/img/img-${e}.jpeg',
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
