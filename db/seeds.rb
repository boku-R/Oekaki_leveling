# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  User.create!(
    email: "hoge#{n+1}@example.com",
    password: "password",
    username: "hoge#{n+1}",
    handlename: "ほげ#{n+1}"
    )
end

Admin.create!(
 email: 'admin@admin.com',
 password: 'password'
)