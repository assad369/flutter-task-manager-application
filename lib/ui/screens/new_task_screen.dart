import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_count_by_status_wrapper_model.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/widgets/snackbar_message.dart';
import 'package:task_manager/ui/utility/app_color.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';

import '../../data/models/task_count_by_status_model.dart';
import '../../data/models/task_model.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summery_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskCountByStatusInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskCountByStatusModel> _taskCountByStatusList = [];

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            await _getNewTasks();
            _getTaskCountByStatus();
          },
          child: Column(
            children: [
              buildTaskSummerySection(),
              const SizedBox(height: 8),
              Expanded(
                child: Visibility(
                  visible: _getNewTaskInProgress == false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: _newTaskList[index],
                        onUpdateTask: () {
                          _getNewTasks();
                          _getTaskCountByStatus();
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appPrimaryColor,
        foregroundColor: AppColors.whiteColor,
        onPressed: _onTapAddButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTaskSummerySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Visibility(
        visible: _getTaskCountByStatusInProgress == false,
        replacement: const CenteredProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _taskCountByStatusList.map((e) {
              return TaskSummeryCard(
                title: (e.sId ?? 'unknown').toUpperCase(),
                count: e.sum.toString() ?? '0',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Future<void> _getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getNewTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListsWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      _newTaskList = taskListsWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          'Failed to get tasks! Try again',
          true,
        );
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountByStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          'Failed to get task count by status! Try again',
          true,
        );
      }
    }
    _getTaskCountByStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
