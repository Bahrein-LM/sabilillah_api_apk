import 'package:data_apk/models/student.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {

  final Student student;
  final VoidCallback onTap;

  const StudentCard({
    required this.student,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 12
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondary,
          child: Text(
            student.nama[0],
            style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          student.nama,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyMedium!.color
          ),
        ),
        subtitle: Text(
          student.namaKelas,
          style: TextStyle(
            color: theme.textTheme.bodyMedium!.color
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}