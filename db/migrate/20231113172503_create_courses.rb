class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.integer :credits
      t.string :college_name

      t.timestamps
    end
  end
end
