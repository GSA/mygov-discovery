class TagsController < ApplicationController

  def show
   respond_to do |format|
      format.json { render json: Page.tagged_with(params[:id]), :callback => params[:callback] }
    end
  end

end