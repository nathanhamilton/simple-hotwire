# == Schema Information
#
# Table name: courses
#
#  id           :bigint           not null, primary key
#  course_name  :string
#  credits      :integer
#  college_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Course < ApplicationRecord

  has_many :student_course_records, dependent: :destroy
  broadcasts_to -> (course) { :courses }
end
