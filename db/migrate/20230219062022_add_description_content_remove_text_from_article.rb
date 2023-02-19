class AddDescriptionContentRemoveTextFromArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :description, :text
    add_column :articles, :content, :text
    remove_column :articles, :text
  end
end
