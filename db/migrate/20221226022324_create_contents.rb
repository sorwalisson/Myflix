class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :video_url
      t.belongs_to :title, null: false, foreign_key: true

      t.timestamps
    end
  end
end
