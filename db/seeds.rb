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
  {title:"Comment participer à nos activités ?", content:"Adhérer à l’association (coût familial annuel de 12€) puis s’inscrire à l’activité choisie. Des activités sont aussi proposées gratuitement à des personnes non-membres (spectacle de Noël, fête du quartier, actions en direction des enfants, actions culturelles gratuites, bourse aux jouets, etc.). Enfin des personnes, membres ou non de l’association, peuvent nous aider bénévolement, ponctuellement ou régulièrement (accompagnement scolaire, animation du quartier, bibliothèque, etc.).", category:"maison_de_quartier", user_id:admin.id},
  {title:"Conférence: géologie et patrimoine rural", content:"Reportage réalisé par Joël Vial sur les vieilles fermes autour de 5 roches et de 5 régions de France vendredi 20 janvier à 18h à la maison de quartier. Activité gratuite ouverte à tous.", category:"news", user_id:admin.id},
  {title:"Spectacle de Noël", content:'Spectacle de marionnettes "Mirabelle et ses amis" par la Compagnie 3 chardons lundi 19 décembre à 15h30 à la maison de quartier.Activité gratuite ouverte à tous', category:"news", user_id:admin.id},
  {title:"Lecture de textes", content:'L\'association "DES MOTS ET DES VOIX" nous propose une lecture de textes: « Par ici la monnaie ». Chansons, poésies, contes, fables, extraits de romans, extraits de théâtre…  Vendredi 8 avril 2022 à 20h à la Maison de Quartier Croix-Berthaud. Activité gratuite ouverte à tous', category:"news", user_id:admin.id},
  {title:"Carnaval", content:'Animations en partenariat avec la ville de Saint-Chamond.', category:"a_l_affiche", user_id:admin.id},
  {title:"Jardin partagé", content:'La ville et l’Opac ont créé en avril 2009 le premier “jardin partagé” de la vallée du Gier. Il est installé à proximité de la Maison de Quartier, et notre association apporte son soutien à cette action citoyenne. Venez seul ou en famille cultiver le jardin et partager la récolte des légumes, des fruits et des fleurs. Activité gratuite. Les personnes intéressées peuvent se joindre au groupe d’habitants. Contact : Madame Alguacil, au 06 27 88 52 98', category:"a_l_affiche", user_id:admin.id},
  {title:"Fête du quartier", content:'La Maison de Quartier invite les habitants, ses adhérents et amis, à une fête de quartier avec animations gratuites, animation musicale et pique-nique. Ouvert aux enfants, jeunes et adultes. Les infos détaillées seront données en mai prochain. Cette fête se déroulera le Samedi 25 mai 2024 de 12h à 18h. Accès libre et gratuit.', category:"a_l_affiche", user_id:admin.id},
  {title:"Bibliothèque et lecture de contes", content:'La bibliothèque est ouverte tous les mercredis de 10h à 11h. Lecture sur place et prêt de livres. Activité gratuite et ouverte à tous', category:"activites_enfants", user_id:admin.id},
  {title:"Animations durant les vacances", content:'La Maison de quartier propose pendant les petites vacances scolaires des animations ou activités gratuites pour les enfants du quartier entre 6 et 12 ans, que leur famille soit ou non adhérente de l’association. Les informations sont données quelques semaines avant.', category:"activites_enfants", user_id:admin.id},
  {title:"Peinture enfants (6-12ans)", content:'Expérimenter diverses techniques pour pouvoir s’exprimer. Public : 6-12 ans. Dates  et horaires des cours : mercredi de 11h15 à 12h15, reprise le mercredi 20 septembre 2023. Tarif 2023/2024 : 65€ ( dispositif mercredi découvertes). Intervenante : Hélène Navarro', category:"activites_enfants", user_id:admin.id},
  {title:"Zumba ados (12-17 ans)", content:'La zumba est une danse facile, fun et festive, inspirée des rythmes latins, qui permet de brûler des calories. Sentez la musique et laissez-vous aller! Dates et horaires des cours : mercredi de 18h30 à 19h45, reprise le mercredi 20 septembre 2023. Tarif 2023/2024 : 105€ en 1 fois ou en 3 chèques de 35€ + cotisation (12 €). Intervenante : Lydia Linde', category:"activites_enfants", user_id:admin.id},
  {title:"Bibliothèque participative", content:"Déposez et prenez gratuitement des livres et des revues sur l'étagère située dans l'entrée de la maison de quartier.", category:"activites_adultes", user_id:admin.id},
  {title:"Goûter littéraire", content:"Venez échanger autour des livres que vous avez aimés et partager un goûter. Dates et horaires des rencontres : les mardis 3 octobre 2023, 5 décembre 2023, 6 février 2024, 2 avril 2024 et 4 juin 2024 de 14h à 16h. Ouvert à tous, accès libre et gratuit. Responsable Annick Keromnes", category:"activites_adultes", user_id:admin.id},
  {title:"Atelier de réparation", content:"Venez réparer vos objets en panne avec l'aide de bénévoles compétents (petits appareils électriques, vélos, jouets...). Outils fournis. Atelier gratuit, ouvert à tous, 1 vendredi sur 2 de 16h à 18h. Prochain atelier: vendredi 22 septembre", category:"activites_adultes", user_id:admin.id},
  {title:"Questionnaire santé", content:'Le questionnaire santé sera mis en ligne prochainement. Il est nécessaire pour certaines activités.', category:"programme", user_id:admin.id}
]

articles.each do |article|
  Article.create!(title:article[:title], content:article[:content], category:article[:category], user_id: admin.id)
end

activities = [
  {name:"Anglais", price:114, period:2023},
  {name:"Equilibre et mouvement", price:99, period:2023},
  {name:"Chorale", price:135, period:2023},
  {name:"Danse enfants", price:114, period:2023},
  {name:"Danse de salon", price:81, period:2023},
]

activities.each do |activity|
  Activity.create!(name:activity[:name], price:activity[:price], period:activity[:period])
end

10.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "123456"
  )
  2.times do
    Comment.create(
      content: Faker::Lorem.sentence,
      user_id: user.id,
      article_id: Article.all.sample.id
    )
  end
  if rand(2) == 0
    family_member = FamilyMember.create!(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      birthdate: Faker::Date.birthday(min_age: 12, max_age: 80),
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
