class Clinic < ActiveRecord::Base
  validates_uniqueness_of :title
  validates_presence_of :title, :price
end
