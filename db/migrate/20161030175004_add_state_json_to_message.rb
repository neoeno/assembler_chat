class AddStateJsonToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :state_json, :text
  end
end
