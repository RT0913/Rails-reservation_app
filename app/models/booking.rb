class Booking < ApplicationRecord
  
  belongs_to :user
  belongs_to :room
  
  validates :user_id, :room_id, :check_in, :check_out, :num_guests, presence: true
  
end
