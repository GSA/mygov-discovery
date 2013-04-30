class RatingsController < ApplicationController
  
  def create
    rating = Rating.find_or_initialize_by_page_id_and_user_id(params[:page_id], @current_user.id)
    rating.value = params[:value]
    if rating.save
      render json: rating.as_json, status: :created 
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end  
end