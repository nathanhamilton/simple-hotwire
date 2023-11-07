class StudentCourseRecord < ApplicationRecord

  has_one :student
  broadcasts_to -> (student_course_record) { :student_course_records }
end
