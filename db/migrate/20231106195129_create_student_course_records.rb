class CreateStudentCourseRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :student_course_records do |t|
      t.integer :student_id
      t.string :name
      t.date :start_date
      t.date :end_date
      t.date :registered_at
      t.integer :credits
      t.string :score

      t.timestamps
    end
  end
end
