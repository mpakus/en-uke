class AddContentIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :content_id, :integer, index: true
  end
end
