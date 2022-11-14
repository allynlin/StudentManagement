package com.cshbxy.service;

import com.cshbxy.pojo.Student;
import com.cshbxy.pojo.User;

import java.util.List;

public interface StudentService {

  Student findStudentById(int id);
  List<Student> findStudentsByName(String username);

  List<Student> findStudentsByClass(String userclass);

  int addStudent(Student student);

  int updateStudent(Student student);

  int deleteStudent(int id);
}
