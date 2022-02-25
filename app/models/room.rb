class Room < ApplicationRecord
  
  belongs_to :user
  has_many :booking
  
  validates :name, :room_comment, :room_charge, :address, :room_image, :user_id, presence: true
  
  def user
    return User.find_by(id: self.user_id)
  end

end
