class Student < ApplicationRecord

  enum_for :married, { single: 1, married: 2 }
  enum_for :sex, { male: 1, female: 2 }

  has_many :student_course_records, dependent: :destroy
end
