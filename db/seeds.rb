# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_number = 15
article_number = 30

Api::Comment.destroy_all
Api::Article.destroy_all
User.destroy_all

user_number.times do |i|
  User.create(
    email:"user#{i}@yopmail.com",
    password:"nico123",
    password_confirmation:"nico123"
  )
  system("clear")
  puts "#{i+1} users created"
  puts "|"+("█"*(i+1))+(" "*((user_number-1)-i))+"|"

end


article_number.times do |i|
  Api::Article.create(
    title:Faker::Artist.name,
    content:Faker::ChuckNorris.fact,
    private:[true,false,false].sample,
    user_id:User.all.sample.id
  )
  system("clear")
  puts "#{i+1} articles created"
  puts "|"+("█"*(i))+(" "*((article_number-1)-i))+"|"
  
end

Api::Article.all.each_with_index do |article,i|
  Api::Comment.create(
    content:Faker::ChuckNorris.fact,
    user_id:User.all.sample.id,
    article_id:article.id
  )
  Api::Comment.create(
    content:Faker::ChuckNorris.fact,
    user_id:User.all.sample.id,
    article_id:article.id
  )
  system("clear")
  puts "#{(i+1)*2} comments created"
  puts "|"+("█"*(i))+(" "*((Api::Article.all.length-1)-i))+"|"
end

puts ""
puts "Enjoy 🥃 !!!"
puts "----------->"