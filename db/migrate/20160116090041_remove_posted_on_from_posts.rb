class RemovePostedOnFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :posted_on, :datetime
  end
end
