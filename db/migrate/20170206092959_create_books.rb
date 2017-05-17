class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :author
      t.string :description
      t.string :title
      t.string :image
      t.datetime :publish_date
      t.integer :number_of_pages
      t.float :rating, default: 0.0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
