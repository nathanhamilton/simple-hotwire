class Course < ApplicationRecord

  has_many :student_course_records, dependent: :destroy
  broadcasts_to -> (course) { :courses }
end
