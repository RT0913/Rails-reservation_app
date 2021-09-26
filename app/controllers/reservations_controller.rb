class ReservationsController < ApplicationController
 
  def home
    @user = User.find_by(id: params[:id])
  end
  
end
