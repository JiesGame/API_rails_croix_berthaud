Article.destroy_all
User.destroy_all
Comment.destroy_all
Activity.destroy_all

admin = User.create(
  email: ENV["ADMIN_EMAIL"],
  password: ENV["ADMIN_PASSWORD"],
  is_admin: true
)

25.times do
  Article.create(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraphs,
    category: rand(6),
    user_id: admin.id
  )
end

activities = [
  {name:"Anglais", price:114, period:2023},
  {name:"Equilibre et mouvement", price:99, period:2023},
  {name:"Chorale", price:135, period:2023},
  {name:"Danse enfants", price:114, period:2023},
  {name:"Danse de salon", price:81, period:2023},
]

activities.each do |activity_data|
  Activity.create!(name:activity_data[:name], price:activity_data[:price], period:activity_data[:period])
end

10.times do
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
  if rand(2) == 0
    family_member = FamilyMember.create!(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      birthdate: Faker::Date.birthday(min_age: 18, max_age: 80),
      legaltutorfirstname: Faker::Name.first_name,
      legaltutorlastname: Faker::Name.last_name,
      phonenumber: Faker::PhoneNumber.phone_number,
      homephonenumber: Faker::PhoneNumber.phone_number,
      adresse: Faker::Address.street_address,
      user_id: user.id
    )
    activity = Activity.all.sample
    FamilyMemberActivity.create(
      family_member: family_member,
      activity: activity,
      validation: true
    )
  end
end
