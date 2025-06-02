import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/common_widgets/async_value_ui.dart';
import 'package:flutter_todo/common_widgets/async_value_widget.dart';
import 'package:flutter_todo/features/authentication/data/auth_repository.dart';
import 'package:flutter_todo/features/authentication/domain/task.dart';
import 'package:flutter_todo/features/task_management/controllers/firestore_controller.dart';
import 'package:flutter_todo/features/task_management/data/firstore_repository.dart';
import 'package:flutter_todo/features/task_management/presentation/widgets/task_item.dart';
import 'package:flutter_todo/utils/app_styles.dart';

class AllTasksScreen extends ConsumerWidget {
  const AllTasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final taskAsyncValue = ref.watch(loadTasksProvider(userId));

    ref.listen<AsyncValue>(loadTasksProvider(userId), (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks',
            style: AppStyles.titleTextStyle.copyWith(color: Colors.white)),
      ),
      body: AsyncValueWidget<List<Task>>(
          value: taskAsyncValue,
          data: (tasks) {
            return tasks.isEmpty
                ? Center(
                    child: Text(
                      'No tasks available',
                      style: AppStyles.headingTextStyle,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (ctx, height) =>
                        const Divider(height: 2, color: Colors.blue),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskItem(task: task);
                    },
                  );
          }),
    );
  }
}
