import 'package:flutter/material.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  NoteDetailScreenState createState() => NoteDetailScreenState();
}

class NoteDetailScreenState extends State<NoteDetailScreen> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note.content);
  }

  void _updateNoteContent() {
    setState(() {
      widget.note.content = _controller.text;
    });
  }

  void _saveNote() async {
    _updateNoteContent();
    await FirestoreService().updateNote(widget.note);
  }

  void _saveNoteAndNotify() async {
    _saveNote();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Note Detail'),
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
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveNoteAndNotify();
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.note.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _isEditing
                ? TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  )
                : Text(widget.note.content,
                    style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
