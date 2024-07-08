import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_summery_card.dart';

Widget buildTaskSummerySection() {
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        TaskSummeryCard(
          title: 'New task',
          count: '34',
        ),
        TaskSummeryCard(
          title: 'Progress',
          count: '09',
        ),
        TaskSummeryCard(
          title: 'Completed',
          count: '44',
        ),
        TaskSummeryCard(
          title: 'Cancelled',
          count: '12',
        ),
      ],
    ),
  );
}
