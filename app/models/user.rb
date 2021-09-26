class User < ApplicationRecord
  
  has_many :room, dependent: :destroy
  has_many :booking, dependent: :destroy
  
  def rooms
    return Room.where(user_id: self.id)
  end

end
