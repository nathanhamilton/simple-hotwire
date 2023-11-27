class RemoveCreditsColumnFromStudentCourseRecords < ActiveRecord::Migration[7.1]
  def up
    remove_column :student_course_records, :credits
  end

  def down
    add_column :student_course_records, :credits, :integer
  end
end
