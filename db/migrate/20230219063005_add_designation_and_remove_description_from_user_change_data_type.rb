class AddDesignationAndRemoveDescriptionFromUserChangeDataType < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :designation
    add_column :users, :designation, :string
  end
end
