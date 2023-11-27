# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

unless Rails.env.production?
  25.times do
    Student.create!(name: Faker::Name.name,
                    email: Faker::Internet.email,
                    age: rand(18..30),
                    married: [true, false].sample,
                    address: Faker::Address.street_address,
                    city: Faker::Address.city,
                    state: Faker::Address.state,
                    zip: Faker::Address.zip_code)
  end

  50.times do
    Course.create!(course_name: Faker::Educator.course_name, credits: rand(1..5), college_name: Faker::University.name)
  end

  courses = Course.all

  Student.all.each do |student|
    rand(4..9).times do
      student.student_course_records.create!(course_id: courses.sample.id, start_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
                                             end_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
                                             registered_at: Faker::Date.between(from: 1.year.ago, to: Date.today),
                                             score: rand(1..100))
    end
  end
end

