import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          GoRouter.of(context).pop();
        },
        label: const Text('Simpan'),
        icon: const Icon(Icons.save),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukan Judul',
                    hintStyle:
                        TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold
                          )
                        ),
                controller: _titleController,
              ),
              TextFormField(
                maxLines: 100,
                style: TextStyle(
                  fontSize: 15),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukan Deskripsi',
                    ),
                controller: _descController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
