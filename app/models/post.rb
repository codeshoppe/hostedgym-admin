class Post < ActiveRecord::Base
  validates :title, :body, :posted_on, presence: true
end
