# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.now)
end

100.times do |n|
  name = Faker::Internet.slug(nil, ' ')
  courses = Faker::Number.digit.to_i
  min_weeks = Faker::Number.digit.to_i
  reminders = n % 2
  min_spacing_weeks = Faker::Number.digit.to_i if courses > 1
  max_spacing_weeks = Faker::Number.digit.to_i if courses > 1
  notes = Faker::Lorem.paragraph
  Treatment.create!(name: name,
                    courses: courses,
                    min_weeks: min_weeks,
                    reminders: reminders,
                    min_spacing_weeks: min_spacing_weeks,
                    max_spacing_weeks: max_spacing_weeks,
                    notes: notes)
end
