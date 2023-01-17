class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.string :name
      t.integer :genre, default: 0
      t.boolean :available, default: true
      t.string :content_rating
      t.integer :kind, default: 0
      t.json :title_information
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end
