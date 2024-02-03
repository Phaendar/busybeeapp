import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:busybeelearning/services/auth.dart';
import 'package:busybeelearning/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documments from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  /// Reads all documments from the topics collection
  Future<List<LessonTopic>> getLessonTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var lessontopics = data.map((d) => LessonTopic.fromJson(d));
    return lessontopics.toList();
  }

  /// Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  /// Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  /// Updates the current user's report document after completing quiz
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };

    return ref.set(data, SetOptions(merge: true));
  }

  /// Reads all documents from the notes collection
  /// belonging to the current user
  /// and returns a stream of notes
  Stream<List<Note>> streamNotes() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db
            .collection('notes')
            .doc(user.uid)
            .collection('notes')
            .orderBy('createdAt', descending: true);
        return ref.snapshots().map((list) {
          List<Note> notes = list.docs.map((doc) {
            return Note.fromJson(doc.data());
          }).toList();
          return notes;
        });
      } else {
        return Stream.fromIterable([<Note>[]]);
      }
    });
  }

  /// Creates a new note document in Firestore
  /// belonging to the current user
  /// and returns the document id
  Future<String> createNote(Note note) async {
    var user = AuthService().user!;
    var ref = _db.collection('notes').doc(user.uid).collection('notes').doc();

    var newNote = Note(
      id: ref.id,
      title: note.title,
      content: note.content,
      uid: user.uid,
      createdAt: DateTime.now(),
    );

    await ref.set(newNote.toJson());
    return ref.id;
  }

  Future<List<Note>> getNotes() async {
    var user = AuthService().user!;
    var ref = _db.collection('notes').doc(user.uid).collection('notes');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var notes = data.map((d) => Note.fromJson(d));
    return notes.toList();
  }

  Future<void> deleteNote(String noteId) async {
    var user = AuthService().user!;
    var ref =
        _db.collection('notes').doc(user.uid).collection('notes').doc(noteId);
    await ref.delete();
  }

  Future<void> updateNote(Note note) async {
    var user = AuthService().user!;
    var ref =
        _db.collection('notes').doc(user.uid).collection('notes').doc(note.id);

    await ref.update({
      'title': note.title,
      'content': note.content,
      // ... any other fields you have in the Note model ...
    });
  }
}
