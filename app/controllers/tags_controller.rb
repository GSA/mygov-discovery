class TagsController < ApplicationController

  def show
   respond_to do |format|
      format.json { render json: Page.tagged_with(params[:id]), :callback => params[:callback] }
    end
  end
  
  def index
    respond_to do |format|
      if params[:q].nil?
        format.json { head :bad_request }
      else
        format.json { render json: ActsAsTaggableOn::Tag.named_like( params[:q] ), :callback => params[:callback] }
      end
    end
  end
  
end