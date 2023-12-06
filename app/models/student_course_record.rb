# == Schema Information
#
# Table name: student_course_records
#
#  id            :bigint           not null, primary key
#  student_id    :integer
#  start_date    :date
#  end_date      :date
#  registered_at :date
#  score         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id     :integer
#  order         :integer
#
class StudentCourseRecord < ApplicationRecord

  belongs_to :student
  belongs_to :course
  broadcasts_to -> (student_course_record) { :student_course_records }, inserts_by: :prepend
  broadcasts_refreshes
end
