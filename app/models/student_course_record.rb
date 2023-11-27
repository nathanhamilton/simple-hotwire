class StudentCourseRecord < ApplicationRecord

  belongs_to :student
  belongs_to :course
  broadcasts_to -> (student_course_record) { :student_course_records }
end
