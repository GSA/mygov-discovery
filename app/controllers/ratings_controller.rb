class RatingsController < ApplicationController
  
  #allow user to create rating by POSTing to /pages/1/ratings
  def create
    @rating = Rating.new
    @rating.user_id = @current_user.id
    @rating.page_id = params[:page_id]
    @rating.value = params[:value]
    respond_to do |format|
      if @rating.save
        format.json { render json: @rating.as_json, status: :created }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
  
end