import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/no_data.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: context.theme.textTheme.displaySmall),
        centerTitle: true,
      ),
      body: const NoData(text: 'This is History Screen Screen'),
    );
  }
}
