class AddColumnToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :room_image, :string
    add_column :bookings, :room_name, :string
    add_column :bookings, :room_comment, :text
  end
end
