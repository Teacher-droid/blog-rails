class CreateApiComments < ActiveRecord::Migration[6.1]
  def change
    create_table :api_comments do |t|
      t.text :content
      t.references :article, index: true

      t.timestamps
    end
  end
end
