class AddStateToLinks < ActiveRecord::Migration
  def change
    add_column :links, :state, :integer, default: 0, index: true
  end
end
