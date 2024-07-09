import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getProgressTasks(),
        child: Visibility(
          visible: _getProgressTaskInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: _progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: _progressTaskList[index],
                onUpdateTask: () {
                  _getProgressTasks();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTasks() async {
    _getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProgressTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListsWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _progressTaskList = taskListsWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          'Failed to get tasks! Try again',
          true,
        );
      }
    }
    _getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
