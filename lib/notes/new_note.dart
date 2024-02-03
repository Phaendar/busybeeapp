import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();

  Future<void> handleNote(BuildContext context) async {
    if (_titleController.text.isEmpty) {
      _showErrorDialog('Title cannot be empty');
    } else if (_controller.document.toPlainText().length > 1000) {
      _showErrorDialog('Notes cannot be longer than 1000 characters');
    } else {
      try {
        await FirestoreService().createNote(Note(
          title: _titleController.text,
          content: _controller.document.toPlainText(),
          createdAt: DateTime.now(),
        ));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        // Handle any error that might occur
        _showErrorDialog('Error creating note');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(5, 5),
                  blurRadius: 15.0,
                ),
              ],
              gradient: customcolor.AppColor.customGradient),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              controller: _titleController,
              key: const Key('note-title'),
              autofocus: true,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
          ),
          Expanded(
            child: QuillEditor(
              key: const Key('note-content'),
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              configurations: QuillEditorConfigurations(
                  controller: QuillController.basic()),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: () => handleNote(context),
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
