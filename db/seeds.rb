# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times do
#   User.create(username: Faker::Internet.user_name, password: Faker::Internet.password, email: Faker::Internet.email)
# end
#
# 15.times do
#   Sub.create(name: [Faker::App.name, Faker::Hacker.noun, Faker::Hacker.adjective, Faker::Commerce.department].sample,
#             description: [Faker::Company.catch_phrase, "", Faker::Company.bs], moderator_id: rand(50) )
# end

# 80.times do
#   post = Post.new(author_id: rand(1..50), title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph)
#   (rand(4) == 1 ? rand(1..6) : 1).times do
#     post.subs << Sub.find(rand(1..15))
#   end
#   post.save
# end
#
Post.all.each do |post|
  5.times do
    post.comments.create(author_id: rand(1..50), content: Faker::Lorem.paragraph )
  end
end

200.times do |new_com|
  parent_comment = Comment.all.sample
  Comment.create(author_id: rand(1..50), parent_comment: parent_comment, post: parent_comment.post, content: Faker::Lorem.paragraph )
end
