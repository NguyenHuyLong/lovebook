class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.string :reported_user

      t.timestamps
    end
  end
end
