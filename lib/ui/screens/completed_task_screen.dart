import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;

  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await _getCompletedTasks();
        },
        child: Visibility(
          visible: _getCompletedTaskInProgress == false,
          replacement: const CenteredProgressIndicator(),
          child: ListView.builder(
            itemCount: _completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: _completedTaskList[index],
                onUpdateTask: () {
                  _getCompletedTasks();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTasks() async {
    _getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getCompletedTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListsWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _completedTaskList = taskListsWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          'Failed to get tasks! Try again',
          true,
        );
      }
    }
    _getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
