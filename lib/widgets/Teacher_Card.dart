import 'package:flutter/material.dart';
import 'package:school_management/model/Teacher_Model.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  final   VoidCallback  onEdit;
  final  VoidCallback onDelete;

  const TeacherCard({super.key,
    required this.teacher,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(padding: EdgeInsetsGeometry.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child:  Text(
                teacher.Name.isNotEmpty?
                    teacher.Name[0].toUpperCase():'?',
              ),
            ),
            SizedBox(width: 16,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher.Name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(teacher.Email),

                SizedBox(height: 5),

                Text('Age: ${teacher.Age}'),
              ],
            ),
            ),
            PopupMenuButton<String>(onSelected: (value){
              if(value == 'edit'){
                onEdit();
              }
              if(value == 'delete'){
                onDelete();
              }

            },
              itemBuilder: (context){
              return [PopupMenuItem(value: 'edit',
                  child: Text('Edit'),
              ),
                PopupMenuItem(value: 'delete',
                    child: Text('Delete'),
                ),
              ];
              },
            ),
          ],
        ),
      ),

    );
  }
}
