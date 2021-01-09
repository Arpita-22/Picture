class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :image_url
      t.bigint :width
      t.bigint :height
      t.string :format
      t.bigint :size_in_bytes
      t.text :title
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
