import 'dart:core';

import 'package:flutter/material.dart';
import 'package:school_management/model/Teacher_Model.dart';
import 'package:school_management/services/Teacher_Service.dart';

class TeacherFormScreen extends StatefulWidget {
  final Teacher? teacher;
  const TeacherFormScreen({super.key,
    required this.teacher
  });

  @override
  State<TeacherFormScreen> createState() => _TeacherFormScreenState();
}

class _TeacherFormScreenState extends State<TeacherFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final  TeacherService _teacherService = TeacherService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();


  bool _isSaving = false;

  @override
  void initState(){
    super.initState();
    if(widget.teacher != null){
      _nameController.text = widget.teacher!.Name;
      _emailController.text = widget.teacher!.Email;
      _ageController.text = widget.teacher!.Age.toString();

    }
  }
  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();

    super.dispose();

  }

  Future<void> _saveTeacher()async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      _isSaving = true;
    });
    try {
      final teacher = Teacher(Id: widget.teacher?.Id ?? '',
          Name: _nameController.text.trim(),
          Email: _emailController.text.trim(),
          Age: int.parse(_ageController.text.trim()),

    );
      if(widget.teacher == null){
        await _teacherService.createTeacher(teacher);
      }else{
        await _teacherService.updateTeacher(teacher);
      }
      if(mounted){
        Navigator.pop(context,true);
      }
    }catch(error){
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: $error",
          ),
          ),
        );
      }
      } finally{
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }





  @override
  Widget build(BuildContext context
 ) {
  final  bool isEditing = widget.teacher != null;


    return Scaffold(
      appBar:  AppBar(
        title: Text(isEditing?'Edit Teacher': 'Add Teacher',),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsetsGeometry.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText:  'Enter teacher name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator:  (value){
                if (value == null || value.trim().isEmpty){
                  return 'Please enter the teacher name';
                }
                return null;
              }
            ),

            SizedBox(height: 16,),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText:  'Enter an teacher email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return 'Please an email';
                }
                if(!value.contains('@')){
                  return 'Please enter a valid email';
                }
                return null;
              },

            ),
            SizedBox(height: 16),
            TextFormField(controller: _ageController,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                labelText: 'Age',
                hintText: 'Enter teacher age',
                border:  OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today)
              ),
              validator:  (value ){
              if(value == null || value.trim().isEmpty){
                return 'Please enter the age ';
              }
              final age = int.tryParse(value.trim(),);
              if(age == null){
                return 'Age must be a number';
              }
              return null;
              }
            ),
            SizedBox(height: 52,
              child: ElevatedButton(onPressed: _isSaving ? null : _saveTeacher,

               child: _isSaving?
                   SizedBox(height: 24,width: 24,
                     child: CircularProgressIndicator(),
                   )
                   : Text(isEditing?
               'Update Teacher': 'Add Teacher',
               ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
