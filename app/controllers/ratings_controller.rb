class RatingsController < ApplicationController
  
  def create
    rating = @current_user.ratings.new(:value => params[:value])
    rating.page_id = Page.find(params[:page_id]).id
    if rating.save
      render json: rating.as_json, status: :created 
    else
      render json: rating.errors, status: :unprocessable_entity
    end
  end  
end