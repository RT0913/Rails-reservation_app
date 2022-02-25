class AddColumnsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :check_in, :date
    add_column :bookings, :check_out, :date
    add_column :bookings, :num_guests, :integer
    add_column :bookings, :ttl_charge, :integer
  end
end
