import 'package:flutter/material.dart';
import 'package:school_management/model/Teacher_Model.dart';
import 'package:school_management/services/Teacher_Service.dart';
import 'package:school_management/widgets/Teacher_Card.dart';

import 'Teacher_Form_Screen.dart';

class TeacherListScreen extends StatefulWidget {
  const TeacherListScreen({super.key});

  @override
  State<TeacherListScreen> createState() => _TeacherListScreenState();
}

 class _TeacherListScreenState extends State<TeacherListScreen> {
  final TeacherService _teacherService = TeacherService();

  List<Teacher> _teachers =[];
  bool _isLoading = true;
  @override
  void initState(){
  super.initState();
  _loadTeachers();
  }
  
  Future<void> _loadTeachers()async{
    try{
      final teachers = await _teacherService.getTeachers();
      setState(() {
        _teachers = teachers;
        _isLoading = false;
      });
    }catch(error){
      setState(() {
        _isLoading = false;
      });
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (content: Text('Could not load teachers:$error',
        ),
        ),
        );
      }
    }
  }
  Future<void> _deleteTeacher(String id)async {
    try{
      await _teacherService.deleteTeacher(id);
      await _loadTeachers();
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (content: Text('Teacher deleted successfully'),
        ),
        );
      }
    }catch(error){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('could not delete teacher$error',),
        ),
        );
      }
    }
  }
  Future<void> _addTeacher()async {
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TeacherFormScreen(teacher: null),
      ),
    );
    if (result == true) {
      _loadTeachers();
    }


    Future<void> _editTeacher(Teacher teacher) async {
      final result = await Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => TeacherFormScreen(teacher: teacher,),
      ),
      );
      if (result == true) {
        _loadTeachers();
      }
    }
  }
  Future<void> _editTeacher(Teacher teacher) async{
    final result = await Navigator.push(context, MaterialPageRoute(
        builder:(context) => TeacherFormScreen(teacher: teacher,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers'),
      ),
      body: _isLoading?
          Center(
            child: CircularProgressIndicator(),
          )
          : _teachers.isEmpty?
          Center(
            child: Text('No teachers found.',
              style: TextStyle(
                fontSize: 18,),
            ),
          )
          : RefreshIndicator(onRefresh:_loadTeachers,
          child:ListView.builder(padding: EdgeInsetsGeometry.all(16),
              itemCount:_teachers.length,itemBuilder: (context,index){
            final teacher = _teachers[index];
            return TeacherCard(teacher:teacher,
              onEdit: (){
              debugPrint('EDIT tapped: ${teacher.Id}');
              _editTeacher(teacher);
              },
              onDelete: (){
                debugPrint('DELETE tapped: ${teacher.Id}');

              _deleteTeacher(teacher.Id);
              },

            );
              },
          ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: _addTeacher,
        child: Icon(Icons.add),
      ),
    );
  }




  }




