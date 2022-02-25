class RoomsController < ApplicationController
  
 before_action :set_search
 before_action :authenticate_user, only:[:new, :create, :detail]

  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @current_user = User.find_by(id: session[:user_id])
    @room = Room.new(
      name: params[:name],
      room_comment: params[:room_comment],
      room_charge: params[:room_charge],
      address: params[:address],
      room_image: params[:room_image],
      user_id: @current_user.id
      )
    if @room.save
      @room.room_image = "#{@room.id}.jpg"
      room_image = params[:room_image]
      File.binwrite("public/room_images/#{@room.room_image}", room_image.read)
      flash[:notice] = "登録しました"
      redirect_to("/rooms/index")
    else
      flash[:notice] = "入力に誤りがあります"
      @name = params[:name]
      @room_comment = params[:room_comment]
      @rooom_charge = params[:room_charge]
      @address = params[:address]
      render "rooms/new"
    end
  end
  
  def search
    @room = Room.find_by(id: params[:id])
    @rooms_count = @rooms.count
  end
  
  def detail
    @room = Room.find_by(id: params[:id])
    @current_user = User.find_by(id: session[:user_id])
    @booking = Booking.new
  end
  
end
