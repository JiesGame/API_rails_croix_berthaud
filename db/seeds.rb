Article.destroy_all
User.destroy_all
Comment.destroy_all
Activity.destroy_all

admin = User.create(
  email: ENV["ADMIN_EMAIL"],
  password: ENV["ADMIN_PASSWORD"],
  is_admin: true
)

articles = [
  {title:"Qui somme-nous ?", content:"Une association déclarée et sans but lucratif ouverte à toutes et tous. Indépendante des mouvements politiques,religieux, syndicats et intérêts économiques. Elle est animée par son conseil d’administration et plus de 30 bénévoles, qui prennent en charge les activités ainsi que le fonctionnement de l’association. Des intervenants rémunérés encadrent certaines activités.", category:"maison_de_quartier", user_id:admin.id},
  {title:"A qui s'adresse l'association ?", content:"L’association est ouverte à toute personne intéressée par son projet, ses actions, ses activités. La zone géographique de recrutement est d’abord la Croix Berthaud et Grange-Roux ainsi que les quartiers environnants. Des habitants de l’ensemble de Saint-Chamond et des communes voisines nous rejoignent.", category:"maison_de_quartier", user_id:admin.id},
  {title:"Nos actions et activités ?", content:"Animation du quartier, en offrant à ses habitants un lieu de rencontre et de convivialité. Contribution à l'amélioration du cadre de vie. Actions culturelles, socio-éducatives, de détente et de loisirs en direction des enfants, jeunes et adultes.", category:"maison_de_quartier", user_id:admin.id},
  {title:"Comment participer à nos activités ?", content:"Une association déclarée et sans but lucratif ouverte à toutes et tous. Indépendante des mouvements politiques,religieux, syndicats et intérêts économiques. Elle est animée par son conseil d’administration et plus de 30 bénévoles, qui prennent en charge les activités ainsi que le fonctionnement de l’association. Des intervenants rémunérés encadrent certaines activités.", category:"maison_de_quartier", user_id:admin.id},

]
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
