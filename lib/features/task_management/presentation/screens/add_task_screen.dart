import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/common_widgets/async_value_ui.dart';
import 'package:flutter_todo/features/authentication/controllers/auth_controller.dart';
import 'package:flutter_todo/features/authentication/data/auth_repository.dart';
import 'package:flutter_todo/features/authentication/domain/task.dart';
import 'package:flutter_todo/features/task_management/controllers/firestore_controller.dart';
import 'package:flutter_todo/features/task_management/presentation/widgets/title_description.dart';
import 'package:flutter_todo/utils/app_styles.dart';
import 'package:flutter_todo/utils/size_config.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _priorities = [
    'High',
    'Medium',
    'Low',
  ];
  int _selectedPriority = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final userId = ref.watch(currentUserProvider)!.uid;
    final state = ref.watch(firestoreControllerProvider);

    ref.listen<AsyncValue>(firestoreControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    void validateDetails() {
      String title = _titleController.text;
      String description = _descriptionController.text;

      if (title.isEmpty || description.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Title and Description cannot be empty")),
        );
        return;
      } else {
        String priority = _priorities[_selectedPriority];
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        String date = DateTime.now().toString();
        bool isComplete = false;
        final Task task = Task(
            id: id,
            title: title,
            description: description,
            priority: priority,
            date: date,
            isComplete: isComplete);
        // If validation passes, navigate to the main screen
        ref
            .read(firestoreControllerProvider.notifier)
            .addTask(task: task, userId: userId);
        // context.goNamed(AppRoutes.main.name);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task',
            style: AppStyles.titleTextStyle.copyWith(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateWidth(20),
            vertical: SizeConfig.getProportionateHeight(20)),
        child: Column(
          children: [
            TitleDescription(
                title: 'Task Title',
                prefixIcon: Icons.notes,
                hintText: "Enter task Title",
                maxLines: 1,
                controller: _titleController),
            SizedBox(height: SizeConfig.getProportionateHeight(10)),
            TitleDescription(
                title: 'Task Description',
                prefixIcon: Icons.notes,
                hintText: "Enter task Description",
                maxLines: 3,
                controller: _descriptionController),
            SizedBox(height: SizeConfig.getProportionateHeight(20)),

            Row(
              children: [
                Text("Priority",
                    style: AppStyles.headingTextStyle.copyWith(fontSize: 18)),
                Expanded(
                  child: SizedBox(
                      height: SizeConfig.getProportionateHeight(40),
                      child: ListView.builder(
                          itemCount: _priorities.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            final priority = _priorities[index];

                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedPriority = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left:
                                          SizeConfig.getProportionateWidth(10)),
                                  padding: EdgeInsets.all(
                                    SizeConfig.getProportionateWidth(10),
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _selectedPriority == index
                                        ? Colors.green
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    priority,
                                    style: AppStyles.normalTextStyle.copyWith(
                                      color: _selectedPriority == index
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize:
                                          SizeConfig.getProportionateHeight(14),
                                    ),
                                  ),
                                ));
                          })),
                )
              ],
            ),

            SizedBox(height: SizeConfig.getProportionateHeight(36)),
            InkWell(
              onTap: validateDetails,
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.getProportionateHeight(50),
                width: SizeConfig.deviceWidth,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: state.isLoading
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(' Add Task',
                              style: AppStyles.normalTextStyle
                                  .copyWith(color: Colors.white, fontSize: 20))
                        ],
                      ),
              ),
            )
            // Controller will be added later
          ],
        ),
      ),
    );
  }
}
