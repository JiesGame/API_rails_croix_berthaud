Article.destroy_all
User.destroy_all
Comment.destroy_all

admin = User.create(
  email: ENV["ADMIN_EMAIL"],
  password: ENV["ADMIN_PASSWORD"],
  is_admin: true
)

6.times do
  Article.create(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraphs,
    user_id: admin.id,
  )
end

5.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "123456"
  )
  2.times do
    Comment.create(
      content: Faker::Lorem.paragraphs,
      user_id: user.id,
      article_id: Article.all.sample.id
    )
  end
end
