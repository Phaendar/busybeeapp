import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/notes/note_detail_screen.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Note>>(
      stream: FirestoreService().streamNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Notes',
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.library_music),
                  onPressed: () {
                    Navigator.pushNamed(context, '/musicplayer');
                  },
                ),
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      // dark shadow bottom right
                      BoxShadow(
                        color: Colors.yellow.shade700,
                        offset: const Offset(0, 5),
                        blurRadius: 10.0,
                      ),
                    ],
                    gradient: customcolor.AppColor.customGradient),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg_02.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                      boxShadow: [
                        // dark shadow bottom right
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(5, 5),
                          blurRadius: 15.0,
                        ),
                        // light shadow top left
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-5, -5),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: CupertinoListSection.insetGrouped(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                        boxShadow: [
                          // dark shadow bottom right
                          BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(5, 5),
                            blurRadius: 15.0,
                          ),
                          // light shadow top left
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, -5),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.zero,
                      backgroundColor: customcolor.AppColor.homePageBackground,
                      children: snapshot.data!
                          .map((note) => CupertinoListTile(
                              backgroundColor:
                                  customcolor.AppColor.primaryColor,
                              title: Text(note.title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () async {
                                      await FirestoreService()
                                          .deleteNote(note.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Note deleted successfully!')));
                                    },
                                  ),
                                  const Icon(CupertinoIcons.right_chevron),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NoteDetailScreen(note: note)),
                                );
                              }))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: customcolor.AppColor.customGradient,
                boxShadow: [
                  // dark shadow bottom right
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 15.0,
                  ),
                  // light shadow top left
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/new-note');
                },
                backgroundColor: customcolor.AppColor.primaryColor,
                child: const Icon(Icons.add, color: Colors.black),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(initialIndex: 3),
          );
        } else {
          // Redirect to the NewNoteScreen when no note is found
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/new-note');
          });
          return const SizedBox.shrink(); // Return an empty widget
        }
      },
    );
  }
}
