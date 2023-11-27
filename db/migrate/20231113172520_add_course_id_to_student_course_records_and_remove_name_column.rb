class AddCourseIdToStudentCourseRecordsAndRemoveNameColumn < ActiveRecord::Migration[7.1]
  def up
    add_column :student_course_records, :course_id, :integer
    remove_column :student_course_records, :name
  end

  def down
    add_column :student_course_records, :name, :string
    remove_column :student_course_records, :course_id
  end
end
