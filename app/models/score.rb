class Score < ActiveRecord::Base
  belongs_to :player
  attr_accessible :deaths, :kills
end
