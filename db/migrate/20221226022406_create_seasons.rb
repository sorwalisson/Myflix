class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.integer :number
      t.belongs_to :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
