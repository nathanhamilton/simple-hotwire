# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  name       :string
#  age        :integer
#  sex        :integer
#  married    :boolean
#  address    :string
#  city       :string
#  state      :string
#  zip        :string
#  phone      :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < ApplicationRecord

  enum_for :married, { single: 1, married: 2 }
  enum_for :sex, { male: 1, female: 2 }

  has_many :student_course_records, dependent: :destroy
end
