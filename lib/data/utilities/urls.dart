class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String getNewTask = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTask = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String getProgressTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
}
