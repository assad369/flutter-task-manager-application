import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getCancelledTasks(),
        child: Visibility(
          visible: _getCancelledTaskInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: _cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: _cancelledTaskList[index],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCancelledTasks() async {
    _getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getCancelledTask);

    if (response.isSuccess) {
      TaskListsWrapperModel taskListsWrapperModel =
          TaskListsWrapperModel.fromJson(response.responseData);
      _cancelledTaskList = taskListsWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          'Failed to get tasks! Try again',
          true,
        );
      }
    }
    _getCancelledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
