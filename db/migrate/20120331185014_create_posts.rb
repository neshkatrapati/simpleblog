class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.datetime :time, :default => Time.now
      t.text :content
      t.string :tags
      
      t.timestamps
    end
  end
end
