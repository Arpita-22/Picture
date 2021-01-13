class CreateImageSimilarities < ActiveRecord::Migration[6.0]
  def change
    create_table :image_similarities do |t|
      t.string :tag
      t.string :similar_tag

      t.timestamps
    end
  end
end
