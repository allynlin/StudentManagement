package com.cshbxy.mapper;

import com.cshbxy.pojo.Student;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface StudentMapper {

  @Select("select * from student where id = #{id}")
  Student findStudentById(int id);

  @Select("select * from studentmanagement.student where username like concat('%',#{username},'%')")
  List<Student> findStudentsByName(String username);

  @Select("select * from studentmanagement.student where userclass like concat('%',#{userclass},'%')")
  List<Student> findStudentsByClass(String userclass);

  @Insert("insert into studentmanagement.student(username,age,userclass,filename) values(#{username},#{age},#{userclass},#{filename})")
  int addStudent(Student student);

  @Update("update studentmanagement.student set username =#{username},age = #{age},userclass = #{userclass},filename=#{filename} where id = #{id}")
  int updateStudent(Student student);

  @Delete("delete from studentmanagement.student where id = #{id};")
  int deleteStudent(int id);
}
