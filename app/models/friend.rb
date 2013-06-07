class Friend < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_user_id
end
