# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require "faker"
require "populator"

User.destroy_all
Group.destroy_all
Post.destroy_all

10.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.full_name = Faker::Name.name
  user.email = Faker::Internet.email
  user.password = "test123"
  user.password_confirmation = "test123"
  user.save
end

5.times do
  group = Group.new
  group.name = Faker::Company.name
  group.description = Faker::Company.catch_phrase
  group.user_id = User.all[rand(User.count)].id
  group.save
end

User.all.each do |user|
  Post.populate(1..2) do |post|
    post.user_id = user.id
    post.message = Faker::Lorem.sentence
    post.group_id = Group.all[rand(Group.count)].id
  end

  # TODO - shouldn't be able to add yourself...
  3.times do
    other_users = User.where("id != ?", user.id)
    user.follow(other_users[rand(other_users.count)])
  end

  3.times do
    user.add_group(Group.all[rand(Group.count)])
  end
end

User.all.each do |user|
  5.times do
    comment = Comment.new
    comment.user_id = user.id
    comment.message = Faker::Lorem.sentence
    comment.group_id = Group.all[rand(Group.count)].id

    comment.post_id = Post.all[rand(Post.count)].id
    comment.save

  end
end