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
  group.group_name = Faker::Company.name
  group.group_description = Faker::Company.catch_phrase
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
    user.add_friend(User.all[rand(User.count)])
  end

  3.times do
    user.add_group(Group.all[rand(Group.count)])
  end
end

existing_posts = Post.all
existing_posts_count = Post.count

User.all.each do |user|
  5.times do
    post = Post.new
    post.user_id = user.id
    post.message = Faker::Lorem.sentence
    post.group_id = Group.all[rand(Group.count)].id
    post.topic_id = existing_posts[rand(existing_posts_count)].id
    post.save

  end
end