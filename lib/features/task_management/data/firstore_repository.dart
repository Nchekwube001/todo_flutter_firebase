import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/features/authentication/domain/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'firstore_repository.g.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addTask({required Task task, required String userId}) async {
    final docRef = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add(task.toMap());

    await docRef.update({'id': docRef.id});
  }

  Future<void> updateTask(
      {required Task task,
      required String taskId,
      required String userId}) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update(task.toMap());
  }

  Stream<List<Task>> loadTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('date', descending: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Stream<List<Task>> loadCompletedTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Stream<List<Task>> loadInCompletedTasks(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .where('isComplete', isEqualTo: false)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Future<void> deleteTask(
      {required String userId, required String taskId}) async {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Future<void> updateTaskCompletion(
      {required String userId,
      required String taskId,
      required bool isComplete}) async {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .update({'isComplete': isComplete});
  }
}

@Riverpod(keepAlive: true)
FirestoreRepository firestoreRepository(FirestoreRepositoryRef ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
}

@Riverpod(keepAlive: true)
Stream<List<Task>> loadTasks(Ref ref, String userId) {
  final FirestoreRepository firestoreRepository =
      ref.watch(firestoreRepositoryProvider);

  return firestoreRepository.loadTasks(userId);
}

@Riverpod(keepAlive: true)
Stream<List<Task>> loadCompletedTasks(Ref ref, String userId) {
  final FirestoreRepository firestoreRepository =
      ref.watch(firestoreRepositoryProvider);

  return firestoreRepository.loadCompletedTasks(userId);
}

@Riverpod(keepAlive: true)
Stream<List<Task>> loadInCompletedTasks(Ref ref, String userId) {
  final FirestoreRepository firestoreRepository =
      ref.watch(firestoreRepositoryProvider);

  return firestoreRepository.loadInCompletedTasks(userId);
}
