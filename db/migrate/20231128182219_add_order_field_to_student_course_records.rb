class AddOrderFieldToStudentCourseRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :student_course_records, :order, :integer
  end
end
