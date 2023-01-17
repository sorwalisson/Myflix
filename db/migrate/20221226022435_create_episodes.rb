class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :name
      t.string :video_url
      t.belongs_to :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
