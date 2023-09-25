class CreateFamilyMemberActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :family_member_activities do |t|
      t.references :family_member, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.boolean :validation, default: true

      t.timestamps
    end
  end
end
