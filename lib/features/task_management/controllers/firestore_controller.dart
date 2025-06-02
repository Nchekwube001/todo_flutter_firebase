import 'package:flutter_todo/features/authentication/domain/task.dart';
import 'package:flutter_todo/features/task_management/data/firstore_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_controller.g.dart';

@riverpod
class FirestoreController extends _$FirestoreController {
  @override
  FutureOr<void> build() {
    throw UnimplementedError();
  }

  FutureOr<void> addTask({
    required Task task,
    required String userId,
  }) async {
    state = const AsyncLoading();
    final fireStoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
        () => fireStoreRepository.addTask(task: task, userId: userId));
  }

  FutureOr<void> updateTask({
    required Task task,
    required String userId,
    required String taskId,
  }) async {
    state = const AsyncLoading();
    final fireStoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(() => fireStoreRepository.updateTask(
        task: task, userId: userId, taskId: taskId));
  }

  FutureOr<void> deleteTask({
    required String userId,
    required String taskId,
  }) async {
    state = const AsyncLoading();
    final fireStoreRepository = ref.read(firestoreRepositoryProvider);
    state = await AsyncValue.guard(
        () => fireStoreRepository.deleteTask(userId: userId, taskId: taskId));
  }
}
