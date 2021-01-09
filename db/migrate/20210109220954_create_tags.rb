class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.string :similar_tag

      t.timestamps
    end
  end
end
