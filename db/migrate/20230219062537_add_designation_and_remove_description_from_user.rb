class AddDesignationAndRemoveDescriptionFromUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :designation, :text
    remove_column :users, :description
  end
end
