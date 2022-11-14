package com.cshbxy.service;

import com.cshbxy.mapper.StudentMapper;
import com.cshbxy.mapper.UserMapper;
import com.cshbxy.pojo.Student;
import com.cshbxy.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Allyn
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;


    @Override
    public Student findStudentById(int id){
        return studentMapper.findStudentById(id);
    }

    @Override
    public List<Student> findStudentsByName(String username) {
        return studentMapper.findStudentsByName(username);
    }

    @Override
    public List<Student> findStudentsByClass(String userclass){
        return studentMapper.findStudentsByClass(userclass);
    }

    @Override
    public int addStudent(Student student) {
        return studentMapper.addStudent(student);
    }

    @Override
    public int updateStudent(Student student) {
        return studentMapper.updateStudent(student);
    }

    @Override
    public int deleteStudent(int id) {
        return studentMapper.deleteStudent(id);
    }
}
