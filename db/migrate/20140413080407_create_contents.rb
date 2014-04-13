class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :url, index: true
      t.text :text

      t.timestamps
    end
  end
end
