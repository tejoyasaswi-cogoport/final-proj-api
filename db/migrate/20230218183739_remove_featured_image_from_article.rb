class RemoveFeaturedImageFromArticle < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :featured_image, :string
  end
end
