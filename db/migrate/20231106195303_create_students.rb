class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.integer :sex
      t.boolean :married
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
