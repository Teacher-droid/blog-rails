class CreateApiArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :api_articles do |t|
      t.string :title
      t.text :content
      t.boolean :private, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
