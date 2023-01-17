class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :headline
      t.text :description
      t.integer :score
      t.belongs_to :title, null: false, foreign_key: true

      t.timestamps
    end
  end
end
