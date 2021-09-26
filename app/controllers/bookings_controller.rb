class BookingsController < ApplicationController
  
  before_action :authenticate_user, only:[:index, :confirm]
  
  def index
    @current_user = User.find_by(id: session[:user_id])
    @bookings = Booking.where(user_id: @current_user.id)
  end
  
  def confirm
    @room = params[:room_id]
    @room = Room.find(@room)
    @booking = Booking.new(
      user_id: @current_user.id,
      room_id: params[:room_id],
      check_in: params[:check_in],
      check_out: params[:check_out],
      num_guests: params[:num_guests]
    )
    session[:booking] = @booking
    if @booking.invalid?
      redirect_to "/rooms/#{@room.id}/detail"
    else
      @booking.ttl_charge = (@booking.check_out - @booking.check_in).to_i * @booking.num_guests * @room.room_charge
    end
  end
  
  def reconfirm
    @booking = Booking.create!(session[:booking])
    @room = Room.find_by(id: params[:room_id])
    @booking.room_image = @room.room_image
		@booking.room_name = @room.name
		@booking.room_comment = @room.room_comment
    if params[:back]
      redirect_to "/rooms/#{@room.id}/detail"
    else @booking.save!
      session.delete(:booking)
      flash[:notice] = "予約が完了しました"
      redirect_to "/bookings/#{@booking.id}"
    end
  end
  
  def show
    @room = Room.find_by(id: params[:room_id])
    @booking = Booking.find_by(id: params[:id])
  end
  
end
