class CreateFamilyMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :family_members do |t|
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.string :legaltutorfirstname
      t.string :legaltutorlastname
      t.string :phonenumber
      t.string :homephonenumber
      t.string :adresse
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
