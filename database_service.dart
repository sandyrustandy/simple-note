import 'dart:ui';

import 'package:path/path';
import 'package:flutter/material.dart';
import 'package:simple_not/models/note.dart';
import 'package:simple_not/pages/add_note_page.dart';

class DatabaseService{
  DatabaseService._();

  static final DatabaseService db = DatabaseService._();

  static Database? _database;

  //membuat gatter database
  Future<Database?> get database async{
    //Cek Database ada atau tidak

    if(_database != null){
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasepath(),'simple_notes.db'),
      version: 1,
      onCreate: (db, version) async{
        //membuat tabel pertama
        db.execute('''
CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, createdAt date)
''');
      },
    );
  }

  //menambahkan baris dengan objek/model note
  addnewNote(Note note) async{
    final db = await database;

    db!.insert(
      'note', 
      note.toMap(),
      conflictAlgoritm: conflictAlgoritm.replace,
    );
  }

  //mendapatkan database

  Future<dynamic> getAllNotes() async{
    final db = await database;

    var res = await db!.query('notes');

    if(res.isEmpty){
      return null;
    }else{
      var result = res.toList();
      return result.isNotEmpty ? result : null;
    }
  }
  Future<int> updateNote(Note note) async{
    final db = await database;

    var result = await db!.rawUpdate('''
UPDATE notes SET title = "${note.title}", desc = "${note.desc}", createdAt = "${note.createdAt}" WHERE id = ${note.id}
''');
    return result;
  }

  //hapus baris

  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db!.rawDelete('''
DELETE FROM notes WHERE id = ?
'''. [id]);
  return count;
  }
}