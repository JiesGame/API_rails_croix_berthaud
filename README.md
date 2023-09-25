
# THP FINAL PROJECT - La croix berthaud - Back

<img src="https://maison-quartier-croix-berthaud.vercel.app/assets/logo-431786a0.svg">


Création de notre Projet Final en équipe.

Notre github : JiesGame

Lien du site en production : https://api-croix-berthaud-0572b1b3d9d4.herokuapp.com/

Github du frontend : https://github.com/JiesGame/React_vite_croix_berthaud/

Lien du Trello : https://trello.com/b/QNTJJxP8/croixberthaud




## Description

Cette application Rails est l'API en relation avec l'application React du nouveau site de la Maison de quartier - La Croix Berthaud.
Sur le site, l'administrateur peut poster ses articles et proposer des activités. Il peut également administrer l'ensemble du site (Utilisateur, Articles, Activités, etc).
L'utilisateur lui, une fois connecté, peut s'inscrire à l'association et aux différentes activités sur le site.
## Parcours utilisateur
L'utilisateur arrive sur la page "/" qui est le home. Depuis celle-ci, plusieurs possibilités s'offrent à lui. Il peut :

- parcourir les différentes catégories d'articles, et même voir le show de chaque article.
- accéder à la page "/register" pour se créer un compte et/ou à la page de "/login" avec son compte.
- accéder à la page de "/donation" pour faire un don à l'association.
- faire une recherche dans l'input présent dans la barre de navigation, pour rechercher des articles par leurs noms ou leurs contenus.
- depuis le footer, accéder aux CGU, au réglement intérieur, à la page de contact, ainsi qu'au Facebook de l'association et au site de la ville depuis les images cliquables.

Une fois enregistré et connecté, il peut, depuis le bouton "MON COMPTE", accéder à la page "/inscription" pour s'incrire et/ou inscrire les membres de sa famille. Les paiements se font depuis Stripe.
Il a également accès à la page "profil" qui lui permet de voir et éditer son profil. Il lui est également possible de se déconnecter.
## Parcours administrateur

En plus du parcours utilisateur, l'administrateur a dans le déroulant du bouton "MON COMPTE" la possibilité de se rendre sur la page administration qui est par défault sur "/admin_articles". Depuis celle-ci, il peut créer, éditer, commenter ou supprimer chaque article, en les triant par catégorie.
Un composant de notre application du nom de "AdminPanel" permet à l'administrateur de changer de page.
Il peut aller sur la page "/admin_users" pour voir la liste des utilisteurs et supprimer leur compte.
il peut également aller sur la page "/admin_activities" pour éditer les activités.
Pour finir, il peut se rendre sur la page "/admin_inscriptions" pour voir, valider ou refuser des activités des membres d'une famille.

Dans la navbar, le bouton de donation devient pour l'administrateur un bouton de création d'article.
## Application

#### Création de l’application LaCroixBerthaud

Création de l’application MA-VOIRIE

#### Utilisation du framework tailwind et d'une base de données Postgresql

`rails new API_rails_croix_berthaud --api -d postgresql --css tailwind`

#### Réalisation de la base de donnée

- User (devise)
`rails g devise User`

- Article
`rails g scaffold Article`

- Comment
`rails g model Comment`
`rails g controller Comment`

- Rating
`rails g model Rating`
`rails g controller Rating`

- FamilyMember
`rails g model FamilyMember`
`rails g controller FamilyMember`

- Activity
`rails g model Activity`
`rails g controller Activity`

- FamilyMemberActivity
`rails g model FamilyMemberActivity`
`rails g controller FamilyMemberActivity`

<img src="https://trello.com/1/cards/64febf32be863f5667505fb8/attachments/65094d6ffe9b9120c692f64b/previews/65094d70fe9b9120c692f732/download/Test_blog_(3).jpeg" width="1000">

#### Détails des routes

```ruby
Rails.application.routes.draw do

#Les routes générées par devise pour le CRUD des utilisateurs, et les routes nécessaires à la connexion via le front.
  devise_for :users,
            controllers: {
              sessions: 'users/sessions',
              registrations: 'users/registrations'
            }
  get '/member-data', to: 'members#show'

#Les pages statiques du site sont des requêtes particulières
  post 'password/forgot', to: 'password#forgot'
  put 'password/reset/:token', to: 'password#reset'
  put 'password/update', to: 'password#update'
  post 'users/destroy_with_password', to: "users#destroy_with_password"
  get 'articles/category/:category', to: 'articles#index_category'
  get 'articles_all', to: 'articles#index_all_categories'

#Les routes des commentaires et des notes sont imbriquées dans celle des articles.
  resources :articles do
    resources :comments, :rating
  end

#Ajout manuel de ces routes pour nous permettre de passer outre Devise pour nos utilisateurs via le controller, très important pour la gestion de notre BDD.
  resources :users

#Les paiements via stripe 

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  scope '/inscription_checkout' do
    post 'create', to: 'inscription_checkout#create', as: 'inscription_checkout_create'
    get 'success', to: 'inscription_checkout#success', as: 'inscription_checkout_success'
    get 'cancel', to: 'inscription_checkout#cancel', as: 'inscription_checkout_cancel'
  end

#Les routes du tableau admin.
  namespace :admin do
    resources :users
    resources :articles, except: [:show]
    get 'users_with_unvalidated_activities', to: 'users#users_with_unvalidated_activities'
    delete 'user_destroy_by_admin/:id', to: 'users#user_destroy_by_admin'
  end
end
```

## Prérequis

	  Ruby 3.0.0  
	  Rails 7.0.7.2

gem 'rspec-rails'
gem 'faker'
gem "devise", "~> 4.9"
gem "devise-jwt", "~> 0.11.0"
gem "rack-cors", "~> 2.0"
gem 'dotenv-rails'
gem 'table_print'
gem 'stripe'

## L'équipe

- [NicolasCHIRON](https://github.com/NicolasCHIRON)
- [Videloff](https://github.com/Videloff)
- [NicolasVdev](https://github.com/NicolasVdev)