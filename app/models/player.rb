class Player < ActiveRecord::Base
  belongs_to :user
  attr_accessible :alias_name

  validates :alias_name, :presence => true, :uniqueness => true
end
