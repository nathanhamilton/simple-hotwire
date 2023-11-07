class StudentCourseRecordsController < ApplicationController


  def index
    @student = Student.find(params[:student_id])
    @student_course_records = StudentCourseRecord.where(student_id: @student.id)
  end
end
