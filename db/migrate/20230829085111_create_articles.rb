class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, index:true
      t.boolean :private, null:false, default: false

      t.timestamps
    end
  end
end
