import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/model/Teacher_Model.dart';

class TeacherService {
  final String baseUrl = 'http://localhost:5004';

  Future<List<Teacher>> getTeachers()async{
    final response = await http.get(Uri.parse('$baseUrl/api/Teachers'),
    );

    if (response.statusCode  == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Teacher.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load teachers');

    }
}
Future<Teacher> getTeacher(String id)async{

    final response = await http.get(Uri.parse('$baseUrl/api/Teachers/$id'),
    );
    if(response.statusCode == 200){
      return Teacher.fromJson(jsonDecode(response.body),
      );
    }
    throw Exception('Teacher not found');
}
Future<void> createTeacher(Teacher teacher)async{
    final response = await http.post(Uri.parse('$baseUrl/api/Teachers'),

  headers: {
    'Content-Type': 'application/json'
  },

        body: jsonEncode({
    'name': teacher.Name,
    'email': teacher.Email,
    'age': teacher.Age,
  }),
  );
    debugPrint('CREATE BODY: ${response.body}');
    if(response.statusCode == 200 || response.statusCode == 201){
      return;

    }
    throw Exception('Failed to create teacher(${response.statusCode})${response.body}');
  }
  Future<void> updateTeacher(Teacher teacher)async{
    final response = await http.put(Uri.parse('$baseUrl/api/Teachers/${teacher.Id}'),
      headers: {
      'Content-Type': 'application/json',
      },
      body:  jsonEncode({
        'id': teacher.Id,
        'name': teacher.Name,
        'email': teacher.Email,
        'age': teacher.Age,
      }),
    );
    if(response.statusCode == 200 || response.statusCode == 204){
      return;
    }
    throw Exception('Failed to update teacher');
  }

  Future<void> deleteTeacher(String id)async{
    final response = await http.delete(Uri.parse('$baseUrl/api/Teachers/$id'),);
      debugPrint('DELETE URL id=$id status=${response.statusCode}'
    );
    if(response.statusCode == 200 || response.statusCode == 204){
      return;
    }
    throw Exception('Failed to delete teacher(${response.statusCode})${response.body}');
  }
  }


