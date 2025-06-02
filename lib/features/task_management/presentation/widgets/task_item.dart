import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/features/authentication/data/auth_repository.dart';
import 'package:flutter_todo/features/authentication/domain/task.dart';
import 'package:flutter_todo/features/task_management/data/firstore_repository.dart';
import 'package:flutter_todo/utils/size_config.dart';
import 'package:intl/intl.dart';

String formattedDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

  return formattedDate;
}

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  void deleteItem(String taskId) {
    final userId = ref.watch(currentUserProvider)!.uid;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Delete Task'),
              content: const Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(firestoreRepositoryProvider)
                        .deleteTask(userId: userId, taskId: taskId);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));

    // ref
    //     .read(firestoreRepositoryProvider)
    //     .deleteTask(userId: userId, taskId: taskId);
  }

  void updateTask() {
    TextEditingController titleController =
        TextEditingController(text: widget.task.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.task.description);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              icon: Icon(Icons.edit, color: Colors.green, size: 40),
              title: const Text('Update Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final userId = ref.watch(currentUserProvider)!.uid;
                        final updatedTask = Task(
                          id: widget.task.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          priority: widget.task.priority,
                          date: widget.task.date,
                          isComplete: widget.task.isComplete,
                        );
                        ref.read(firestoreRepositoryProvider).updateTask(
                            userId: userId,
                            taskId: widget.task.id,
                            task: updatedTask);
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Update'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.task.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                  value: widget.task.isComplete,
                  onChanged: (bool? value) {
                    if (value == null) {
                      return;
                    } else {
                      final userid = ref.watch(currentUserProvider)!.uid;

                      ref
                          .read(firestoreRepositoryProvider)
                          .updateTaskCompletion(
                              userId: userid,
                              taskId: widget.task.id,
                              isComplete: !widget.task.isComplete);
                    }
                  })
              // IconButton(
              //   icon: Icon(
              //     widget.task.isComplete
              //         ? Icons.check_circle
              //         : Icons.circle_outlined,
              //     color: widget.task.isComplete ? Colors.green : Colors.grey,
              //   ),
              //   onPressed: () {
              //     // Handle task completion toggle
              //   },
              // ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    formattedDate(widget.task.date),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: updateTask,
                    child: Container(
                      height: SizeConfig.getProportionateHeight(30),
                      width: SizeConfig.getProportionateWidth(30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      deleteItem(widget.task.id);
                    },
                    child: Container(
                      height: SizeConfig.getProportionateHeight(30),
                      width: SizeConfig.getProportionateWidth(30),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
