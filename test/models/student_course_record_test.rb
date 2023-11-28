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
require "test_helper"

class StudentCourseRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
