class AddRoomImageNameAddRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :room_image_name, :string
  end
end
